//
//  CoinsCachedDataServiceMock.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//

import Foundation
@testable import YusufAnsar_Task

final class CoinsCachedDataServiceMock: CoinsCachedDataServiceable {
    func getCachedCoinsFromCoreData() -> [YusufAnsar_Task.CryptoCoin] {
        return []
    }

    func saveCoinsToCoreData(coins: [YusufAnsar_Task.CryptoCoin]) {

    }
}
