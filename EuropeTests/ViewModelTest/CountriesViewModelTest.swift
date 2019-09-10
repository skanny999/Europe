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
        
        let countries = [MockProvider.shared.mockCountry, MockProvider.shared.mockCountry, MockProvider.shared.mockCountry]
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
        XCTAssert(countriesViewModel?.country(at: indexPath) === MockProvider.shared.mockCountry)
    }
    
    func testCountryItem() {
        
        let countryItem = CountryItem(with: MockProvider.shared.mockCountry)
        XCTAssertNil(countryItem.body)
        XCTAssert(countryItem.title == "Åland Islands")
        XCTAssertNotNil(countryItem.imageData)
    }
    
    
    
    

    

}
