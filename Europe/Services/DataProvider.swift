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
    let storedDataProvider: StoredDataProvider
    
    init(updateProcessor: UpdateProcessor = UpdateProcessor(),
         storedDataProvider: StoredDataProvider = CoreDataManager.shared) {
        
        self.updateProcessor = updateProcessor
        self.storedDataProvider = storedDataProvider
    }
    
    func storedCountries() -> [Country] {
        
        let storedCountries = try? storedDataProvider.allCountries().get()
        return storedCountries ?? []
    }
    
    func getCountries(completion: @escaping CountriesResult) {
        
        updateProcessor.updateCountries { (countriesUpdateResult) in
            
            let allCountriesResult = self.storedDataProvider.allCountries()
            
            switch (countriesUpdateResult, allCountriesResult) {
                
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

}


