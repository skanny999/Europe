//
//  CountryViewModelTest.swift
//  EuropeTests
//
//  Created by Riccardo on 10/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
import UIKit
@testable import Europe

class CountryViewModelTest: XCTestCase {
    
    var countryViewModel: CountryViewModel?

    override func setUp() {
        
        countryViewModel = CountryViewModel(with: CountriesMockManager.shared.mockCountry)        
    }

    override func tearDown() {
    }

    func testCountryViewModelRowCount() {
        
        XCTAssert(countryViewModel?.rowCount == 4, String(describing: countryViewModel?.rowCount))
    }
    
    func testCountryViewModelCellTypes() {
        
        let flagIndexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(countryViewModel?.item(at: flagIndexPath) is FlagCellItem)
        
        let nameIndexPath = IndexPath(row: 1, section: 0)
        XCTAssertTrue(countryViewModel?.item(at: nameIndexPath) is DetailCellItem)
        XCTAssert(countryViewModel?.item(at: nameIndexPath).title == "Name")
        XCTAssert(countryViewModel?.item(at: nameIndexPath).body == "Åland Islands")
        
        let capitalIndexPath = IndexPath(row: 2, section: 0)
        XCTAssertTrue(countryViewModel?.item(at: capitalIndexPath) is DetailCellItem)
        XCTAssert(countryViewModel?.item(at: capitalIndexPath).title == "Capital")
        XCTAssert(countryViewModel?.item(at: capitalIndexPath).body == "Toreja")
        
        let populationIndexPath = IndexPath(row: 3, section: 0)
        XCTAssertTrue(countryViewModel?.item(at: populationIndexPath) is DetailCellItem)
        XCTAssert(countryViewModel?.item(at: populationIndexPath).title == "Population")
        XCTAssert(countryViewModel?.item(at: populationIndexPath).body == "28,875")
    }
    
    func testFlagCellItem() {
        
        let flagCellItem = FlagCellItem(with: CountriesMockManager.shared.mockCountry)

        XCTAssertNil(flagCellItem.title)
        XCTAssertNil(flagCellItem.body)
        if CountriesMockManager.shared.networkIsConnected {
            XCTAssertNotNil(flagCellItem.imageData)
        } else {
            XCTAssertNil(flagCellItem.imageData)
        }
    }
    
}
