//
//  CoinsServiceMock.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import Foundation
@testable import YusufAnsar_Task

final class CoinsServiceMock: CoinsServiceable {

    func getCoins() async -> Result<YusufAnsar_Task.CryptoCoinsResponse, YusufAnsar_Task.RequestError> {
        return .success(loadJSON(filename: "crypto_response", type: CryptoCoinsResponse.self))
    }

    private func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = Bundle(for: CoinsServiceMock.self).url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}


