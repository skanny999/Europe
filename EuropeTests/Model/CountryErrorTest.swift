//
//  CountryErrorTest.swift
//  EuropeTests
//
//  Created by Riccardo on 11/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Europe

class CountryErrorTest: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }
    
    func testNetworingErrorMessage() {
        
        let networkingError = CountryError.networkingError
        XCTAssert(networkingError.localizedDescription == "We couldn't get the updated european countries, please make sure you are connected to the internet.", networkingError.localizedDescription)
    }
    
    func testParsingErrorMessage() {
        
        let parsingError = CountryError.parsingError
        XCTAssert(parsingError.localizedDescription == "There was a problem parsing the country data.", parsingError.localizedDescription )
        
    }
    
    func testFetchingErrorMessage() {
        
        let fetchingError = CountryError.fetchingError
        XCTAssert(fetchingError.localizedDescription == "There was a problem fetching the countries from Core Data.", fetchingError.localizedDescription)
        
    }
    
    func testSavingErrorMessage() {
        
        let savingError = CountryError.savingError
        XCTAssert(savingError.localizedDescription == "There was a problem saving the updated countries in Core Data." , savingError.localizedDescription)
    }
    
    func testGenericErrorMessage() {
        
        let genericError = CountryError.genericError
        XCTAssert(genericError.localizedDescription == "Something went wrong." ,  genericError.localizedDescription)
    }


}
