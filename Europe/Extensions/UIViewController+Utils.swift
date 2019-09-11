//
//  UIViewController+Utils.swift
//  Europe
//
//  Created by Riccardo on 11/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func showAlert(for error: CountryError) {
        
        let alert = alertController(for: error)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func alertController(for error: CountryError) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Ooops", message: error.errorDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        return alertController
    }
    
}
