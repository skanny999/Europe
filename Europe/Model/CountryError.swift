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
    case genericError(description: String, code: Int?)
}

extension CountryError {
    
    var friendlyDescription: String {
        
        switch self {
        case .networkingError(let error):
            return error.debugDescription
        case .parsingError(let error):
            return error.debugDescription
        case .fetchingError(let error):
            return error.debugDescription
        case .savingError(let error):
            return error.debugDescription
        case .genericError(let description, _):
            return description
        }
    }
    
}
