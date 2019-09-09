//
//  CellLoadable.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

protocol CellLoadable {
    
    static var identifier: String { get }
    static var nib: UINib { get }
}

protocol CellItem {
    
    var image: UIImage? { get }
    var title: String? { get }
    var body: String? { get }
}


extension CellLoadable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
