//
//  Coordinator.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    func start() {
        
        instantiateCountriesViewController()
        
    }
    
    func showDetail() {
        
        
    }
}


extension Coordinator {
    
    func instantiateCountriesViewController() {
        
        DataProvider.updatedCountries { (result) in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countries):
                let countriesViewModel = CountriesViewModel(with: countries)
                self.instantiateViewController(with: countriesViewModel)
            }
        }
    }
    
    func instantiateViewController(with viewModel: TableViewModel) {
        
        let viewController = ViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = self
        push(viewController, animated: true)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
}
