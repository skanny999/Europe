//
//  CoordinatorTest.swift
//  EuropeTests
//
//  Created by Riccardo on 16/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
import UIKit
@testable import Europe

class CoordinatorTest: XCTestCase {
    
    var coordinator: Coordinator?

    override func setUp() {
        let navigationController = UINavigationController()
        coordinator = Coordinator(with: navigationController)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_countriesViewController() {
        
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
