//
//  DataProcessor.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData

class DataProcessor {
    
    static func processCountries(with data: Data, completion: @escaping (Result<[Country], CountryError>) -> Void) {
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            
            let group = DispatchGroup()
            
            for countryData in json {
                
                group.enter()
                CoreDataManager.shared.performBackgroundTask { (backgroundContext) in
                    
                    Country.managedObject(dictionary: countryData, in: backgroundContext)
                    group.leave()
                }
            }
            
            group.notify(queue: .global()) {
                
                self.deleteObsoleteCountries(from: json) {
                    
                    do {
                        try CoreDataManager.shared.save()
                        completion(DataProvider.allCountries())
                    } catch {
                        completion(.failure(.parsingError(nil)))
                    }
                }
            }
        }
    }
    
    private static func deleteObsoleteCountries(from list: [[String: Any]], completion: @escaping () -> Void) {

        CoreDataManager.shared.performBackgroundTask { (backgroundContext) in

            if let result = DataProvider.obsoleteCountries(from: list, in: backgroundContext) {

                for country in result {

                    backgroundContext.delete(country)
                }
            }

            completion()
        }
    }
}


// MARK: - Core Data managed object processing

protocol Updatable: NSManagedObject {
    
    static var dataIdentifier: String { get set }
    static var objectIdentifier: String { get set }
    
    func update(with dictionary: [String: Any])
}

extension Updatable where Self: NSManagedObject {
    
    static func managedObject(dictionary: [String: Any], in context: NSManagedObjectContext) {
        
        guard let objectId = dictionary[dataIdentifier] as? String else { return }
        
        if let object = Self.object(withId: objectId, in: context) {
            
            object.update(with: dictionary)
            
        } else {
            
            let name = String(describing: self)
            let entityDescription = NSEntityDescription.entity(forEntityName: name, in: context)
            
            let object = Self(entity: entityDescription!, insertInto: context)
            
            object.update(with: dictionary)
        }
    }
    
    static func object(withId id: String, in context: NSManagedObjectContext) -> Self? {
        
        return try? context.fetch(fetchRequest(forId: id)).first as? Self ?? nil
    }
    
    private static func fetchRequest(forId id: String) -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = NSPredicate(format: "%K == %@", objectIdentifier, id)
        return request
    }
}


