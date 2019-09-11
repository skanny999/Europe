//
//  CountryError.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

enum CountryError: Error {
    
    case networkingError
    case parsingError
    case fetchingError
    case savingError
    case genericError
}

extension CountryError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
        case .networkingError:
            return "We couldn't get the updated european countries, please make sure you are connected to the internet."
        case .parsingError:
            return "There was a problem parsing the country data."
        case .fetchingError:
            return "There was a problem fetching the countries from Core Data."
        case .savingError:
            return "There was a problem saving the updated countries in Core Data."
        case .genericError:
            return "Something went wrong."
        }
    }
}
