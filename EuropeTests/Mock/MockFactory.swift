//
//  MockFactory.swift
//  EuropeTests
//
//  Created by Riccardo on 23/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
@testable import Europe

class MockFactory {
    
    static func networkProviderWithError() -> NetworkProvider {
        
        let urlSessionWithError = URLSessionMock(data: nil, response: nil, error: CountryError.networkingError)
        return NetworkProvider(with: urlSessionWithError)
    }
    
    static func networkProviderWithResponseError() -> NetworkProvider {
        
        let response = HTTPURLResponse(url: URL(string:"Mockurl")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let urlSessionResponseError = URLSessionMock(data: nil, response: response, error: nil)
        return NetworkProvider(with: urlSessionResponseError)
    }
    
    static func networkProviderWithValidResponse() -> NetworkProvider {
        
        let response = HTTPURLResponse(url: URL(string:"Mockurl")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSessionResponseValid = URLSessionMock(jsonDict: ["Mock":"Data" as AnyObject], response: response, error: nil)!
        return NetworkProvider(with: urlSessionResponseValid)
    }
    
//    static func dataProvider(storeDataSuccess: Bool, processDataSuccess: Bool) -> DataProvider {
//        
//        let storedDataProvider = storeDataSuccess ? storedDataWithSuccess() : storedDataWithError()
//        let dataProcessor = processDataSuccess ? processorWithSuccess() : processorWithError()
//        
//        return DataProvider(updateProcessor: dataProcessor, storedDataProvider: storedDataProvider)
//    }
    
    
    
    
    static func processorWithError() -> DataProcessor {
        
        return MockDataProcessor(with: .failure(.parsingError))
    }
    
    static func processorWithSuccess() -> DataProcessor {
        
        return MockDataProcessor(with: .success(true))
    }
    
    static func storedDataWithError() -> StoredDataProvider {
        
        return MockStoreDataProvider(with: .failure(.fetchingError))
    }
    
    static func storedDataWithSuccess() -> StoredDataProvider {
        
        return MockStoreDataProvider(with: .success(CountriesMockManager.shared.mockCountries))
    }
    
    
    
}
