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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkProvider() {
        
        let error = CountryError.genericError(descr: "TestError", code: 401)
        let mockSession = URLSessionMock(data: nil, response: nil, error: error)
        
        let expect = expectation(description: "ErrorTest")
        
        NetworkProvider.getCountries(urlSession: mockSession) { (result) in
            
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssert(error.friendlyDescription == "Test Error", error.friendlyDescription)
            case .success:
                XCTFail()
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
        
        
    }

}
