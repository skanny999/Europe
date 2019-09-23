//
//  CountriesViewModel.swift
//  EuropeTests
//
//  Created by Riccardo on 10/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Europe

class CountriesViewModelTest: XCTestCase {
    
    var countriesViewModel: CountriesViewModel?

    override func setUp() {
        
        let countries = [CountriesMockManager.shared.mockCountry, CountriesMockManager.shared.mockCountry, CountriesMockManager.shared.mockCountry]
        countriesViewModel = CountriesViewModel(with: countries)
    }

    override func tearDown() {
        
    }
    
    func testCountriesViewModelRowCount() {
        
        XCTAssert(countriesViewModel?.rowCount == 3)
    }
    
    func testItemAtIndexPath() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssert(countriesViewModel?.item(at: indexPath) is CountryItem)
    }
    
    func testCountryAtIndexPath() {
        
        let indexPath = IndexPath(row: 0, section: 0)

        XCTAssert(countriesViewModel?.destinationViewModel(for: indexPath)?.title == CountriesMockManager.shared.mockCountry.name)
    }
    
    func testCountryItem() {
        
        let countryItem = CountryItem(with: CountriesMockManager.shared.mockCountry)
        XCTAssertNil(countryItem.body)
        XCTAssert(countryItem.title == "Åland Islands")
        if CountriesMockManager.shared.networkIsConnected {
            XCTAssertNotNil(countryItem.imageData)
        } else {
            XCTAssertNil(countryItem.imageData)
        }
    }
    
    
    
    

    

}
