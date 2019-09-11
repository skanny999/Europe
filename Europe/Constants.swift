//
//  Constants.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct AppStatus {
    
    static let isTesting = UserDefaults.standard.bool(forKey: "isTest")
}


struct Const {
    
    static let europeUrl = URL(string: "https://restcountries.eu/rest/v2/regionalbloc/eu")!
    static let countryEntityName = "Country"
    static let countryDataIdentifier = "alpha3Code"
    static let countryObjectIdentifier = "identifier"
}

