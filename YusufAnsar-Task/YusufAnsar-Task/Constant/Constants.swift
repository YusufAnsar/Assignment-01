//
//  Constants.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import Foundation

enum StringConstants {
    case coinsListTitle

    public var value: String {
        switch self {
        case .coinsListTitle:
            return "Crypto Coins"
        }
    }
}

enum CellIdentifiers {
    case coinCell
    case filterOptionCell

    public var value: String {
        switch self {
            case .coinCell:
                return "CryptoCoinTableViewCell"
            case .filterOptionCell:
                return "FilterOptionCollectionViewCell"

        }
    }
}
