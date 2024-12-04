//
//  CoinsCachedDataServiceable.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//

import Foundation

protocol CoinsCachedDataServiceable {
    func getCachedCoinsFromCoreData() -> [CryptoCoin]
    func saveCoinsToCoreData(coins: [CryptoCoin])
}
