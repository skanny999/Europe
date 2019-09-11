//
//  UIImageView+Utils.swift
//  Europe
//
//  Created by Riccardo Scanavacca on 09/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setFlagImage(with data: Data?) {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        
        if let data = data, let flag = UIImage(data: data) {
            self.image = flag
        } else {
            self.image = europeFlagImage
        }
    }
    
    private var europeFlagImage: UIImage {
        
        return UIImage(named: "europe_flag")!
    }
}
