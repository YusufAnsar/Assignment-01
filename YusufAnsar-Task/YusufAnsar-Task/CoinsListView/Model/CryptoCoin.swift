//
//  CryptoCoin.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//

import UIKit

typealias CryptoCoinsResponse = [CryptoCoin]

// MARK: - CryptoCoin
struct CryptoCoin: Codable {
    let name, symbol: String
    let isNew, isActive: Bool
    let type: CryptoCoinType

    enum CodingKeys: String, CodingKey {
        case name, symbol
        case isNew = "is_new"
        case isActive = "is_active"
        case type
    }

    var newImage: UIImage? {
        isNew ? UIImage(named: "NewLabel") : nil
    }

    var coinImage: UIImage? {
        if isActive {
            return type == .coin ? UIImage(named: "CoinActive") : UIImage(named: "Token")
        } else {
            return UIImage(named: "CoinInactive")
        }
    }
}

// MARK: - CryptoCoinType
enum CryptoCoinType: String, Codable {
    case coin = "coin"
    case token = "token"
}
