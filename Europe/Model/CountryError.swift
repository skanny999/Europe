//
//  CountryError.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

enum CountryError: Error {
    
    case networkingError(Error?)
    case parsingError(Error?)
    case fetchingError(Error?)
    case savingError(Error?)
    case genericError
}

extension CountryError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
        case .networkingError(let error):
            return error?.localizedDescription
        case .parsingError(let error):
            return error?.localizedDescription
        case .fetchingError(let error):
            return error?.localizedDescription
        case .savingError(let error):
            return error?.localizedDescription
        case .genericError:
            return "Something went wrong"
        }
    }
    
}
