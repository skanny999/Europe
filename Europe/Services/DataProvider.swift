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
    
    private let updateManager: UpdateManager
    private let storedDataProvider: StoredDataProvider
    
    init(updateManager: UpdateManager = UpdateManager(),
         storedDataProvider: StoredDataProvider = CoreDataManager.shared) {
        
        self.updateManager = updateManager
        self.storedDataProvider = storedDataProvider
    }
    
    func currentCountries() -> [Country] {
        
        let storedCountries = try? storedDataProvider.allCountries().get()
        return storedCountries ?? []
    }
    
    func updatedCountries(completion: @escaping CountriesResult) {
        
        updateManager.updateCountries { (countriesUpdateResult) in
            
            let allCountriesResult = self.storedDataProvider.allCountries()
            
            switch (countriesUpdateResult, allCountriesResult) {
                
            case (.success, .failure):
                completion(.failure(.noCountriesError))
                
            case (.failure, .failure):
                completion(.failure(.noCountriesError))
                
            case (.failure(let updateError), .success(let countries)):
                countries.isEmpty ? completion(.failure(updateError)) : completion(.success(countries))

            case (.success, .success(let countries)):
                completion(.success(countries))
            }
        }
    }

}


