//
//  Int+Utils.swift
//  Europe
//
//  Created by Riccardo on 09/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension Int64 {
    
    var stringValue: String {

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self)) ?? "0"
    }
}
