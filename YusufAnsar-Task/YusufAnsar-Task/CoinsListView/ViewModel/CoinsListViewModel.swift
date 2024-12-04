//
//  CoinsListViewModel.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import Foundation

final class CoinsListViewModel {
    
    private let coinsService: CoinsServiceable
    private let cachedDataService: CoinsCachedDataServiceable
    private var coins: [CryptoCoin]?
    private var searchTerm = ""
    lazy var appliedFilters: [FilterOption] = []
    weak var coinsListView: CoinsListViewProtocol?

    init(coinsService: CoinsServiceable, cachedDataService: CoinsCachedDataServiceable) {
        self.coinsService = coinsService
        self.cachedDataService = cachedDataService
    }

    func getCryptoCoins() async {
        let cachedCoins = cachedDataService.getCachedCoinsFromCoreData()
        var isCachedDataLoaded = false
        if !cachedCoins.isEmpty {
            self.coins = cachedCoins
            coinsListView?.refreshScreen()
            isCachedDataLoaded = true
        } else {
            debugPrint("No cached data available")
        }

        if !isCachedDataLoaded {
            coinsListView?.showScreenLoader()
        }
        let result = await self.coinsService.getCoins()
        coinsListView?.hideScreenLoader()
        switch result {
            case .success(let coinsResponse):
                coins = coinsResponse
                cachedDataService.saveCoinsToCoreData(coins: coinsResponse)
                coinsListView?.refreshScreen()
            case .failure(let error):
                if !isCachedDataLoaded {
                    coinsListView?.showErrorAlert(title: "Error", message:  error.customMessage)
                } else {
                    debugPrint(error.customMessage)
                }
        }
    }

    private func getFilteredCoins() -> [CryptoCoin] {
        guard let coins = self.coins else {
            return []
        }
        var filteredCoins = [CryptoCoin]()
        if appliedFilters.contains(FilterOption.activeCoins) || appliedFilters.contains(FilterOption.inactiveCoins) {
            if appliedFilters.contains(FilterOption.activeCoins) {
                let activeCoins = coins.filter { $0.isActive }
                filteredCoins.append(contentsOf: activeCoins)
            }
            if appliedFilters.contains(FilterOption.inactiveCoins) {
                let inactiveCoins = coins.filter { !$0.isActive }
                filteredCoins.append(contentsOf: inactiveCoins)
            }
        } else {
            filteredCoins = coins
        }

        if appliedFilters.contains(FilterOption.onlyCoins) {
            filteredCoins = filteredCoins.filter { $0.type == .coin }
        }
        if appliedFilters.contains(FilterOption.onlyTokens) {
            filteredCoins = filteredCoins.filter { $0.type == .token }
        }
        if appliedFilters.contains(FilterOption.newCoins) {
            filteredCoins = filteredCoins.filter { $0.isNew }
        }
        if !searchTerm.isEmpty {
            filteredCoins = filteredCoins.filter { coin in
                coin.name.lowercased().contains(searchTerm.lowercased()) ||
                coin.symbol.lowercased().contains(searchTerm.lowercased())
            }
        }
        return filteredCoins
    }
}


extension CoinsListViewModel: CoinsListViewModelProtocol {

    var cryptoCoins: [CryptoCoin] {
        getFilteredCoins()
    }

    func fetchCryptoCoins() {
        Task {
            await getCryptoCoins()
        }
    }

    func didClickFilterOption(at index: Int) {
        let filterOption = FilterOption.allCases[index]
        if let index = appliedFilters.firstIndex(of: filterOption)  {
            appliedFilters.remove(at: index)
        } else {
            appliedFilters.append(filterOption)
            // to handle mutually exlcusive filters onlyCoin and only Token
            if filterOption == .onlyCoins,
               let index = appliedFilters.firstIndex(of: .onlyTokens){
                appliedFilters.remove(at: index)
            }
            if filterOption == .onlyTokens,
               let index = appliedFilters.firstIndex(of: .onlyCoins){
                appliedFilters.remove(at: index)
            }
        }
        coinsListView?.reloadScreen()
    }

    func didSearch(forSearchText searchText: String) {
        self.searchTerm = searchText
        coinsListView?.reloadScreen()
    }

}
