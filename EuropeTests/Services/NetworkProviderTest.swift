//
//  NetworkingTest.swift
//  EuropeTests
//
//  Created by Riccardo Scanavacca on 10/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Europe

class NetworkingTest: XCTestCase {

    override func setUp() {


    }

    override func tearDown() {

    }
    
    func testNetworkError() {
        
        let expect = expectation(description: "ErrorTest")
        
        let networkProvider = MockFactory.networkProviderWithError()
        
        networkProvider.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssert(error.localizedDescription == "We couldn't get the updated european countries, please make sure you are connected to the internet.", error.localizedDescription)
            case .success:
                XCTFail()
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
    
    func testResponseError() {

        let networkProvider = MockFactory.networkProviderWithResponseError()
        
        let expect = expectation(description: "ErrorTest")
        
        networkProvider.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)

            case .success:
                XCTFail()
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
    
    func testDataSuccess() {
        
        let networkProvider = MockFactory.networkProviderWithData()
        
        let expect = expectation(description: "ErrorTest")
        
        networkProvider.getCountries { (result) in
            
            switch result {
            case .failure:
                XCTFail()
            case .success(let data):
                XCTAssertNotNil(data)
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
    
    func testValidDataInvalidResponseFail() {
        
        let response = HTTPURLResponse(url: URL(string:"Mockurl")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let mockSession = URLSessionMock(jsonDict: ["Mock":"Data" as AnyObject], response: response, error: nil)!
        
        let networkProvider = NetworkProvider(with: mockSession)
        
        let expect = expectation(description: "ErrorTest")
        
        networkProvider.getCountries { (result) in
            
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                
            case .success:
                XCTFail()
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }

}
