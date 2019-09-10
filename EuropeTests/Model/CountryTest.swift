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
    
    var countryJson: [String: Any]?

    override func setUp() {
        
        self.countryJson = MockProvider.mockCountryJson
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountryModel() {
        
//        let data = FileExtractor.extractJsonFile(withName: "Country", forClass: type(of: self))
//
//        let jsonArray = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
//        let jsonObject = jsonArray.first!
//        
        let country = Country(entity: NSEntityDescription.entity(forEntityName: "Country", in: MockProvider.context)!, insertInto: MockProvider.context)
        country.update(with: countryJson!)
        
        XCTAssert(country.name == "Åland Islands", "\(String(describing: country.name))")
        XCTAssert(country.capital == "Mariehamn", "\(String(describing: country.capital))")
        XCTAssert(country.identifier == "ALA", "\(String(describing: country.identifier))")
        XCTAssert(country.population == 28875, "\(String(describing: country.population))")
        XCTAssertNotNil(country.flagData)
    }

}
