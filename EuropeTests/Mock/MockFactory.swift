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
    
    // MARK: - network
    
    static func networkProviderWithError() -> NetworkProvider {
        
        let urlSessionWithError = URLSessionMock(data: nil, response: nil, error: CountryError.networkingError)
        return NetworkProvider(with: urlSessionWithError)
    }
    
    static func networkProviderWithResponseError() -> NetworkProvider {
        
        let response = HTTPURLResponse(url: URL(string:"Mockurl")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let urlSessionResponseError = URLSessionMock(data: nil, response: response, error: nil)
        return NetworkProvider(with: urlSessionResponseError)
    }
    
    static func networkProviderWithData() -> NetworkProvider {
        
        let response = HTTPURLResponse(url: URL(string:"Mockurl")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSessionResponseValid = URLSessionMock(jsonDict: ["Mock":"Data" as AnyObject], response: response, error: nil)!
        return NetworkProvider(with: urlSessionResponseValid)
    }
    
    // MARK: - data processor
    
    static func processorWithError() -> DataProcessor {
        
        return MockDataProcessor(with: .failure(.parsingError))
    }
    
    static func processorWithSuccess() -> DataProcessor {
        
        return MockDataProcessor(with: .success(true))
    }
    
    // MARK: - stored data
    
    static func storedDataWithError() -> StoredDataProvider {
        
        return MockStoreDataProvider(with: .failure(.fetchingError))
    }
    
    static func storedDataWithSuccess() -> StoredDataProvider {
        
        return MockStoreDataProvider(with: .success(CountriesMockManager.shared.mockCountries))
    }
    
    // MARK: - update manager
    
    static func updateManager(networkSuccess: Bool, dataProcessorSuccess: Bool) -> UpdateManager {
        
        let networkProvider = networkSuccess ? networkProviderWithData() : networkProviderWithError()
        let dataProcessor = dataProcessorSuccess ? processorWithSuccess() : processorWithError()
        
        return UpdateManager(with: networkProvider, dataProcessor: dataProcessor)
    }
    
    // MARK: - data provider
    
    static func dataProviderWithStoredCountries() -> DataProvider {
        
        let storedDataProvider = MockFactory.storedDataWithSuccess()
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: true)
        return DataProvider(updateManager: updateManager,
                            storedDataProvider: storedDataProvider)
    }
    
    static func dataProviderWithoutStoredCountries() -> DataProvider {
        
        let storedDataProvider = MockFactory.storedDataWithError()
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: true)
        return DataProvider(updateManager: updateManager,
                            storedDataProvider: storedDataProvider)
    }
    
    static func dataProviderNetworkError() -> DataProvider {
        
        let storedDataProvider = MockFactory.storedDataWithError()
        let updateManager = MockFactory.updateManager(networkSuccess: false, dataProcessorSuccess: false)
        return DataProvider(updateManager: updateManager,
                            storedDataProvider: storedDataProvider)
    }
    
    static func dataProviderParsingkError() -> DataProvider {
        
        let storedDataProvider = MockFactory.storedDataWithError()
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: false)
        return DataProvider(updateManager: updateManager,
                            storedDataProvider: storedDataProvider)
    }
    
    static func dataProviderParsingErrorWithStoredCountries() -> DataProvider {
        
        let storedDataProvider = MockFactory.storedDataWithSuccess()
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: false)
        return DataProvider(updateManager: updateManager,
                            storedDataProvider: storedDataProvider)
    }
    
    
    
    static func dataProviderUpdateSuccess() -> DataProvider {
        
        let storedDataProvider = MockFactory.storedDataWithSuccess()
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: true)
        return DataProvider(updateManager: updateManager,
                            storedDataProvider: storedDataProvider)
    }
    
    
    
    
}
