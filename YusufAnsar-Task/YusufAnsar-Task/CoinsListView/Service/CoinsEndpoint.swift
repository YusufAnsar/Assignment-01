//
//  CoinsEndpoint.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import Foundation

enum CoinsEndpoint {
    case getCoins
}

extension CoinsEndpoint: Endpoint {
    var path: String {
        switch self {
            case .getCoins:
                return "/"
        }
    }

    var method: RequestMethod {
        switch self {
            case .getCoins:
                return .get
        }
    }

    var header: [String: String]? {
        switch self {
            case .getCoins:
                return [
                    "Content-Type": "application/json;charset=utf-8"
                ]
        }
    }

    var body: [String: String]? {
        switch self {
            case .getCoins:
                return nil
        }
    }
}
