//
//  CoreDataManager.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataManager: CoreDataProvider {
    
    private static var manager: CoreDataManager?
    private var container: NSPersistentContainer
    private var backgroundContext: NSManagedObjectContext
    
    public static var shared: CoreDataManager {
        
        if manager == nil {
            manager = CoreDataManager()
        }
        return manager!
    }
    
    public var mainContext: NSManagedObjectContext {
        
        return container.viewContext
    }
    
    
    private init() {

        container = NSPersistentContainer(name: "Europe")
        
        if AppStatus.isTesting {
            CoreDataManager.setInMemoryStoreType(for: container)
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = container.viewContext
        
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        
        let backgroundContext = CoreDataManager.shared.backgroundContext
        backgroundContext.perform {
            block(backgroundContext)
        }
    }

    func save() throws {
        
        if backgroundContext.hasChanges {
            
            try backgroundContext.save()
            try mainContext.save()
        }
    }
    
    static func setInMemoryStoreType(for container: NSPersistentContainer) {
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
    }
}


extension CoreDataManager: StoredDataProvider {
    
    func allCountries() -> Result<[Country], CountryError> {
        
        return fetchCountries(with: countriesFetchRequest(), in: mainContext)
    }
    
    
    private func fetchCountries(with request: NSFetchRequest<NSFetchRequestResult>, in moc: NSManagedObjectContext) -> Result<[Country], CountryError> {
         
         do {
             if let countries = try moc.fetch(request) as? [Country] {
                 return .success(countries)
             } else {
                 return .failure(.fetchingError)
             }
             
         } catch {
             return .failure(.fetchingError)
         }
     }
     
     private func countriesFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
         
         let request: NSFetchRequest<NSFetchRequestResult> = Country.fetchRequest()
         request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
         return request
     }
    
}



