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
        
        countryViewModel = CountryViewModel(with: MockProvider.shared.mockCountry)        
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
        XCTAssertTrue(countryViewModel?.item(at: nameIndexPath) is NameCellItem)
        
        let capitalIndexPath = IndexPath(row: 2, section: 0)
        XCTAssertTrue(countryViewModel?.item(at: capitalIndexPath) is CapitalCellItem)
        
        let populationIndexPath = IndexPath(row: 3, section: 0)
        XCTAssertTrue(countryViewModel?.item(at: populationIndexPath) is PopulationCellItem)
    }
    
    func testFlagCellItem() {
        
        let flagCellItem = FlagCellItem(with: MockProvider.shared.mockCountry)
        
        XCTAssertNotNil(flagCellItem.imageData)
        XCTAssertNil(flagCellItem.title)
        XCTAssertNil(flagCellItem.body)
    }
    
    func testNameCellItem() {
        
        let flagCellItem = NameCellItem(with: MockProvider.shared.mockCountry)
        
        XCTAssertNil(flagCellItem.imageData)
        XCTAssert(flagCellItem.title == "Name")
        XCTAssert(flagCellItem.body == "Åland Islands", String(describing: flagCellItem.body))
    }
    
    func testCapitalCellItem() {
        
        let capitalCellItem = CapitalCellItem(with: MockProvider.shared.mockCountry)
        
        XCTAssertNil(capitalCellItem.imageData)
        XCTAssert(capitalCellItem.title == "Capital")
        XCTAssert(capitalCellItem.body == "Mariehamn", String(describing: capitalCellItem.body))
    }
    
    func testPopulationCellItem() {
        
        let populationCellItem = PopulationCellItem(with: MockProvider.shared.mockCountry)
        
        XCTAssertNil(populationCellItem.imageData)
        XCTAssert(populationCellItem.title == "Population")
        XCTAssert(populationCellItem.body == "28,875", String(describing: populationCellItem.body))
    }
    
    

}
