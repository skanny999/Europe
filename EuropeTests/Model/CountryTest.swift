//
//  CountryTest.swift
//  EuropeTests
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
import CoreData
@testable import Europe

class CountryTest: XCTestCase {
    
    var country: Country!

    override func setUp() {
        
        country = CountriesMockManager.shared.mockCountry
    }

    override func tearDown() {

    }

    func testCountryModel() {
        
        XCTAssert(country.name == "Åland Islands", "\(String(describing: country.name))")
        XCTAssert(country.capital == "Toreja", "\(String(describing: country.capital))")
        XCTAssert(country.identifier == "ALA", "\(String(describing: country.identifier))")
        XCTAssert(country.population == 28875, "\(String(describing: country.population))")
        if CountriesMockManager.shared.networkIsConnected {
            XCTAssertNotNil(country.flagData)
        } else {
            XCTAssertNil(country.flagData)
        }
    }

}
