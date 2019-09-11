//
//  CoreDataManager.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
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



