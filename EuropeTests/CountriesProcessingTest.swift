//
//  CountriesProcessingTest.swift
//  EuropeTests
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
import CoreData
@testable import Europe

class CountriesProcessingTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelProcessor() {
        
        let exp1 = expectation(description: "countries")
        
        let data = FileExtractor.extractJsonFile(withName: "Countries", forClass: type(of: self))
        
        DataProcessor.processCountries(with: data) { (result) in
            
            let countries = try! result.get()
            
            print(countries.first!.identifier!)
            print(countries.last!.identifier!)
            
            XCTAssert(countries.count == 2, "\(countries.count)")
            
            XCTAssert(countries.first?.name == "Åland Islands", countries.first!.name!)
            XCTAssert(countries.first?.capital == "Toreja", countries.first!.capital!)
            
            XCTAssert(countries.last?.name == "Italia")
            XCTAssert(countries.last?.capital == "Roma")
            
            print("fulfill exp1")
            exp1.fulfill()
            
        }
        print("waiting for expectation 1")
        wait(for: [exp1], timeout: 3)
        
        let exp2 = expectation(description: "country")
        
        let countryData = FileExtractor.extractJsonFile(withName: "Country", forClass: type(of: self))
        
        print("start processing second file")
        DataProcessor.processCountries(with: countryData) { (result) in
            
            let countries = try! result.get()
            
            XCTAssert(countries.count == 1, "\(countries.count)")
            XCTAssert(countries.first?.name == "Åland Islands")
            XCTAssert(countries.first?.capital == "Mariehamn")
            
            exp2.fulfill()
        }
        
        wait(for: [exp2], timeout: 3)
    }

}
