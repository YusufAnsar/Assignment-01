//
//  CoinsServiceable.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//

import Foundation

protocol CoinsServiceable {
    func getCoins() async -> Result<CryptoCoinsResponse, RequestError>
}

struct CoinsService: HTTPClient, CoinsServiceable {
    
    func getCoins() async -> Result<CryptoCoinsResponse, RequestError> {
        return await sendRequest(endpoint: CoinsEndpoint.getCoins, responseModel: CryptoCoinsResponse.self)
    }
}


