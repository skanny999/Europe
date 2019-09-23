//
//  MockProvider.swift
//  EuropeTests
//
//  Created by Riccardo Scanavacca on 10/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData
import Network
@testable import Europe

class CountriesMockManager {
    
    private var countries = [Country]()
    private var context: NSManagedObjectContext?
    private let monitor = NWPathMonitor()

    static let shared: CountriesMockManager = CountriesMockManager()

    var networkIsConnected: Bool = false
    
    var mockCountries: [Country] {
        return countries
    }
    
    var mockCountry: Country {
        return countries.first!
    }
    
    init() {
        
        if countries.isEmpty {
            
            let context = inMemoryManagedObjectContext()
            self.context = context
            createCountries(in: context)
        }
        configureMonitor()
    }
}

private extension CountriesMockManager {
    
    func configureMonitor() {
        
        monitor.pathUpdateHandler = { path in
            self.networkIsConnected = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func createCountries(in context: NSManagedObjectContext) {
        for countryDict in mockCountriesJson {
            let entity = NSEntityDescription.entity(forEntityName: Const.countryEntityName,
                                                    in: context)!
            let country = Country(entity: entity, insertInto: context)
            country.update(with: countryDict)
            countries.append(country)
        }
        try! context.save()
    }
    
    var mockCountriesJson: [[String: Any]] {
        
        let data = FileExtractor.extractJsonFile(withName: "Countries", forClass: CountriesMockManager.self)
        
        let jsonArray = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
        return jsonArray
    }
    
    func inMemoryManagedObjectContext() -> NSManagedObjectContext {
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from:[Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}



