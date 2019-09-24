//
//  DataProviderTest.swift
//  EuropeTests
//
//  Created by Riccardo on 23/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Europe

class DataProviderTest: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {

    }

    func test_dataProviderWithStoredCountries() {
        
        let dataProvider = MockFactory.dataProviderWithStoredCountries()
        
        let countries = dataProvider.currentCountries()
        XCTAssert(countries.count == 3)
    }
    
    func test_dataProviderWithoutStoredCountries() {

        let dataProvider = MockFactory.dataProviderWithoutStoredCountries()
        
        let countries = dataProvider.currentCountries()
        XCTAssert(countries.isEmpty)
    }
    
    func test_dataProviderFailedNetworkUpdate() {

        let dataProvider = MockFactory.dataProviderNetworkError()
        
        let exp = expectation(description: "updateFailed")
        dataProvider.updatedCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                if case CountryError.noCountriesError = error {
                } else {
                    XCTFail()
                }
            case .success:
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_dataProviderFailedParsingUpdate() {
        
        let dataProvider = MockFactory.dataProviderParsingkError()
        
        let exp = expectation(description: "updateFailed")
        dataProvider.updatedCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                if case CountryError.noCountriesError = error {
                } else {
                    print(error)
                    XCTFail()
                }
            case .success:
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_dataProviderUpdateErrorWithStoredCountries() {
        
        let dataProvider = MockFactory.dataProviderParsingErrorWithStoredCountries()
        
        let exp = expectation(description: "updateSuccess")
        dataProvider.updatedCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure:
                XCTFail()
            case .success(let countries):
                XCTAssert(countries.count == 3)
            }
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_dataProviderUpdateSuccess() {
        
        let dataProvider = MockFactory.dataProviderUpdateSuccess()
        
        let exp = expectation(description: "updateSuccess")
        dataProvider.updatedCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure:
                XCTFail()
            case .success(let countries):
                XCTAssert(countries.count == 3)
            }
        }
        wait(for: [exp], timeout: 1)
    }

}
