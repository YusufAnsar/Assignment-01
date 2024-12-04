//
//  CoinsListViewModelTests.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import XCTest
@testable import YusufAnsar_Task

final class CoinsListViewModelTests: XCTestCase {

    var sut: CoinsListViewModel!

    override func setUpWithError() throws {
        sut = CoinsListViewModel(coinsService: CoinsServiceMock(), cachedDataService: CoinsCachedDataServiceMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetCryptoCoins() async throws {
        await sut.getCryptoCoins()
        XCTAssertTrue(!sut.cryptoCoins.isEmpty, "No crypto coins loaded")
    }

    func testFilterApplication() async throws {
        sut.didClickFilterOption(at: 0)
        XCTAssertTrue(sut.appliedFilters.count == 1, "Failed to apply filter")
        sut.didClickFilterOption(at: 0)
        XCTAssertTrue(sut.appliedFilters.isEmpty, "Failed to unselect appllied filter")
        sut.didClickFilterOption(at: 1)
        sut.didClickFilterOption(at: 2)
        XCTAssertTrue(sut.appliedFilters.count == 2, "Failed to apply multiple filter")
    }

    func testFilteredCoins() async throws {
        await sut.getCryptoCoins()
        // active and new coins
        sut.didClickFilterOption(at: 0)
        sut.didClickFilterOption(at: 4)
        XCTAssertTrue(sut.cryptoCoins.count == 6, "coins filtering is not working properly")

        // apply only tokens filter
        sut.didClickFilterOption(at: 2)
        XCTAssertTrue(sut.cryptoCoins.count == 3, "coins filtering is not working properly")

        // apply only coin filter
        sut.didClickFilterOption(at: 3)
        XCTAssertTrue(sut.cryptoCoins.count == 3, "coins filtering is not working properly")

        // apply new coin filter
        sut.didClickFilterOption(at: 1)
        XCTAssertTrue(sut.cryptoCoins.count == 3, "coins filtering is not working properly")
    }

    func testCoinsSearch() async throws {
        await sut.getCryptoCoins()
        sut.didSearch(forSearchText: "Bit")
        XCTAssertTrue(sut.cryptoCoins.count == 2, "coins search is not working properly")
    }

    func testCoinsSearchAndFilter() async throws {
        await sut.getCryptoCoins()
        sut.didClickFilterOption(at: 2)
        sut.didSearch(forSearchText: "t")
        print(sut.cryptoCoins.count)
        XCTAssertTrue(sut.cryptoCoins.count == 3, "coins search and filter is not working properly")
    }
}
