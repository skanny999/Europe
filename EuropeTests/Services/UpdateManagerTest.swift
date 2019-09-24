//
//  UpdateManagerTest.swift
//  EuropeTests
//
//  Created by Riccardo on 23/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Europe

class UpdateManagerTest: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

    func test_updateProcessorNetworkFailed() {
        
        let updateManager = MockFactory.updateManager(networkSuccess: false, dataProcessorSuccess: false)
        let exp = expectation(description: "failedNetwork")
        updateManager.updateCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                if case CountryError.networkingError = error {
                } else {
                    XCTFail()
                }
            case .success:
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_updateProcessorProcessFail() {
        
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: false)
        let exp = expectation(description: "failedNetwork")
        updateManager.updateCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                if case CountryError.parsingError = error {
                } else {
                    XCTFail()
                }
            case .success:
                XCTFail()
            }
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_updateProcessorSuccess() {
        
        let updateManager = MockFactory.updateManager(networkSuccess: true, dataProcessorSuccess: true)
        let exp = expectation(description: "failedNetwork")
        updateManager.updateCountries { (result) in
            exp.fulfill()
            switch result {
            case .failure:
                XCTFail()
            case .success(let success):
                XCTAssert(success)
            }
        }
        wait(for: [exp], timeout: 1)
    }
}
