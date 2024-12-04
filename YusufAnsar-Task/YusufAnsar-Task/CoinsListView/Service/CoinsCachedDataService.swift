//
//  CoinsCachedDataService.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//

import Foundation
import CoreData

struct CoinsCachedDataService: CoinsCachedDataServiceable {
    
    func getCachedCoinsFromCoreData() -> [CryptoCoin] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CryptoCoinEntity> = CryptoCoinEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map { entity in
                CryptoCoin(name: entity.name ?? "",
                           symbol: entity.symbol ?? "",
                           isNew: entity.isNew,
                           isActive: entity.isActive,
                           type: CryptoCoinType(rawValue:  entity.type ?? "")!)
            }
        } catch {
            print("Failed to fetch from Core Data: \(error)")
            return []
        }
    }
    
    func saveCoinsToCoreData(coins: [CryptoCoin]) {
        let context = CoreDataManager.shared.context

        // Clear existing data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CryptoCoinEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to clear Core Data: \(error)")
        }

        // Save new data
        coins.forEach { coin in
            let entity = CryptoCoinEntity(context: context)
            entity.name = coin.name
            entity.symbol = coin.symbol
            entity.type = coin.type.rawValue
            entity.isActive = coin.isActive
            entity.isNew = coin.isNew
        }

        CoreDataManager.shared.saveContext()
    }
    
}
