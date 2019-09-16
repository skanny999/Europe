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
        self.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        
        instantiateCountriesViewController()
    }
    
    func pushViewController(for viewModel: TableViewModel) {
        
        instantiateViewController(with: viewModel)
    }
}


extension Coordinator {
    
    func instantiateCountriesViewController() {
        
        DataProvider.updatedCountries { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                let countriesViewModel = CountriesViewModel(with: [])
                self?.instantiateViewController(with: countriesViewModel, error: error)
            case .success(let countries):
                let countriesViewModel = CountriesViewModel(with: countries)
                self?.instantiateViewController(with: countriesViewModel)
            }
        }
    }
    
    func instantiateViewController(with viewModel: TableViewModel, error: CountryError? = nil) {
        
        let viewController = ViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.title = viewModel.title
        viewController.coordinator = self
        push(viewController, animated: true)
        if let error = error {
            DispatchQueue.main.async {
              viewController.showAlert(for: error)
            }
        }
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
}
