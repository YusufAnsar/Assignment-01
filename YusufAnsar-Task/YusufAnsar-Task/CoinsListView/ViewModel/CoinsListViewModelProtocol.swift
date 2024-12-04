//
//  CoinsListViewModelProtocol.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import Foundation

protocol CoinsListViewModelProtocol: AnyObject {
    var coinsListView: CoinsListViewProtocol? { get set }
    var cryptoCoins: [CryptoCoin] { get }
    var appliedFilters: [FilterOption] { get }
    func fetchCryptoCoins()
    func didClickFilterOption(at index: Int)
    func didSearch(forSearchText searchText: String)
}
