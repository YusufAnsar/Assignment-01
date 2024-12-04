//
//  FilterOption.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//

import Foundation

enum FilterOption: CaseIterable {
    case activeCoins
    case inactiveCoins
    case onlyTokens
    case onlyCoins
    case newCoins

    var title: String {
        switch self {
            case .activeCoins:
                return "Active Coins"
            case .inactiveCoins:
                return "Inactive Coins"
            case .onlyTokens:
                return "Only Tokens"
            case .onlyCoins:
                return "Only Coins"
            case .newCoins:
                return "New Coins"
        }
    }
}
