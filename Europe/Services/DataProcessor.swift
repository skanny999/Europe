//
//  DataProcessor.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData

class CoreDataProcessor {
    
    func processManagedObjects<T: Updatable>(ofType: T.Type, with data: Data, completion: @escaping (Result<Bool, CountryError>) -> Void) {
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            
            let group = DispatchGroup()
            
            for objectData in json {
                
                group.enter()
                CoreDataManager.shared.performBackgroundTask { (backgroundContext) in
                    
                    T.managedObject(dictionary: objectData, in: backgroundContext)
                    group.leave()
                }
            }
            
            group.notify(queue: .global()) {
                
                self.deleteObsoleteObjects(ofType: T.self, from: json) {
                    
                    do {
                        try CoreDataManager.shared.save()
                        completion(.success(true))
                    } catch {
                        completion(.failure(.parsingError))
                    }
                }
            }
        }
    }
    
    func deleteObsoleteObjects<T: Updatable>(ofType: T.Type, from list: [[String: Any]], completion: @escaping () -> Void) {

        CoreDataManager.shared.performBackgroundTask { (backgroundContext) in

            let currentCountryIdentifiers = list.compactMap{ $0[T.dataIdentifier] as? String }
            let request = T.fetchRequest()
            request.predicate = NSPredicate(format: "NOT %K IN %@", T.objectIdentifier, currentCountryIdentifiers)

            if let obsoleteCountries = try? backgroundContext.fetch(request) as? [T] {

                for object in obsoleteCountries {

                    backgroundContext.delete(object)
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
            guard let entityDescription = NSEntityDescription.entity(forEntityName: name, in: context) else {
                fatalError("Entity without description")
            }
            
            let object = Self(entity: entityDescription, insertInto: context)
            
            object.update(with: dictionary)
        }
    }
    
    static func object(withId id: String, in context: NSManagedObjectContext) -> Self? {
        
        return try? context.fetch(fetchRequest(forId: id)).first as? Self ?? nil
    }

    
    private static func fetchRequest(forId id: String) -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = Self.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = NSPredicate(format: "%K == %@", objectIdentifier, id)
        return request
    }
}


