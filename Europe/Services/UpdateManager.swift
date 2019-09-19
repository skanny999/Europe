//
//  UpdateManager.swift
//  Europe
//
//  Created by Riccardo on 18/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation


class UpdateProcessor {
    
    let networkProvider: NetworkProvider
    let coreDataProcessor: CoreDataProcessor
    
    init(with networkProvider: NetworkProvider = NetworkProvider()) {
        self.networkProvider = networkProvider
        self.coreDataProcessor = CoreDataProcessor()
    }
    
    func updateCountries(completion: @escaping (Result<Bool, CountryError>) -> Void) {
        
        networkProvider.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let data):
                self.coreDataProcessor.processManagedObjects(ofType: Country.self, with: data) { (result) in
                    
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success:
                        completion(.success(true))
                    }
                }
            }
        }
    }
}
