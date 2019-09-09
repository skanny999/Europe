//
//  DataProvider.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData

class DataProvider {
    
    static func updatedCountries(completion: @escaping (Result<[Country], CountryError>) -> Void) {
        
        NetworkProvider.getCountries { (result) in
            
            switch result {
                
            case .failure:
                
                completion(allCountries())
                
            case .success(let data):
                
                DataProcessor.processCountries(with: data, completion: { (result) in
                    
                    completion(result)
                })
            }
        }
    }
    
    static func allCountries() -> Result<[Country], CountryError> {
        
        return fetchCountries(with: countriesFetchRequest(), in: CoreDataManager.shared.mainContext)
    }
    
    static func obsoleteCountries(from list: [[String: Any]], in managedObjectContext: NSManagedObjectContext) -> [Country]? {
        
        let fetchRequest = countriesFetchRequest()
        let currentCountryIdentifiers = list.compactMap{ $0["name"] as? String }
        fetchRequest.predicate = NSPredicate(format: "NOT name IN %@", currentCountryIdentifiers)
        
        return try? fetchCountries(with: fetchRequest, in: managedObjectContext).get()
    }
}

extension DataProvider {
    
    static func fetchCountries(with request: NSFetchRequest<NSFetchRequestResult>, in moc: NSManagedObjectContext) -> Result<[Country], CountryError> {
        
        do {
            if let countries = try moc.fetch(request) as? [Country] {
                return .success(countries)
            } else {
                return .failure(.fetchingError(nil))
            }
            
        } catch {
            return .failure(.fetchingError(error))
        }
    }
    
    static func countriesFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
}
