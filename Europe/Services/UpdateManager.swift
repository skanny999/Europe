//
//  UpdateManager.swift
//  Europe
//
//  Created by Riccardo on 18/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class UpdateManager {
    
    private let networkProvider: NetworkProvider
    private let dataProcessor: DataProcessor
    
    init(with networkProvider: NetworkProvider = NetworkProvider(),
         dataProcessor: DataProcessor = CoreDataProcessor()) {
        self.networkProvider = networkProvider
        self.dataProcessor = dataProcessor
    }
    
    func updateCountries(completion: @escaping (Result<Bool, CountryError>) -> Void) {
        
        networkProvider.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let data):
                self.dataProcessor.processObjects(ofType: Country.self, with: data) { (result) in
                    
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
