//
//  UIImageView+Utils.swift
//  Europe
//
//  Created by Riccardo Scanavacca on 09/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

extension UIImageView {
    
    func setFlagImage(with data: Data?) {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        
        guard let data = data else {
            self.image = europeFlagImage
            return
        }
        
        self.image = UIImage(data: data) ?? SVGKImage(data: data)?.uiImage ?? europeFlagImage
    }
    
    private var europeFlagImage: UIImage {
        
        return UIImage(named: " ")!
    }
}
