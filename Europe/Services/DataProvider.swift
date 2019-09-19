//
//  DataProvider.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreData

typealias CountriesResult = (Result<[Country], CountryError>) -> Void


class DataProvider {
    
    let updateProcessor: UpdateProcessor
    let coreDataProvider: CoreDataProvider
    
    init(updateProcessor: UpdateProcessor = UpdateProcessor(), coreDataProvider: CoreDataProvider = CoreDataManager.shared) {
        
        self.updateProcessor = updateProcessor
        self.coreDataProvider = coreDataProvider
    }
    
    
    func getCountries(completion: @escaping CountriesResult) {
        
        updateProcessor.updateCountries { (countriesUpdateResult) in
            
            let allCountriesFetchResult = self.fetchAllCountries()
            
            switch (countriesUpdateResult, allCountriesFetchResult) {
                
            case (.success, .failure(let fetchError)):
                print("couldn't fetch countries")
                completion(.failure(fetchError))
                
            case (.failure, .failure(let fetchError)):
                print("couldn't updated countries and there's none in memory")
                completion(.failure(fetchError))
                
            case (.failure(let updateError), .success(let countries)):
                print("couldn't update countries \(updateError.localizedDescription)")
                countries.isEmpty ? completion(.failure(updateError)) : completion(.success(countries))

            case (.success, .success(let countries)):
                completion(.success(countries))
            }
        }
    }
    
    
    func fetchAllCountries() -> Result<[Country], CountryError> {
        
        return fetchCountries(with: countriesFetchRequest(), in: coreDataProvider.mainContext)
    }
}

extension DataProvider {
    
    func fetchCountries(with request: NSFetchRequest<NSFetchRequestResult>, in moc: NSManagedObjectContext) -> Result<[Country], CountryError> {
        
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
    
    func countriesFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let request: NSFetchRequest<NSFetchRequestResult> = Country.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
}
