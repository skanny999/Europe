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
    
    func showDetail(for country: Country) {
        
        let countryViewModel = CountryViewModel(with: country)
        instantiateViewController(with: countryViewModel, title: country.name ?? "")
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
                self.instantiateViewController(with: countriesViewModel, title: "Countries")
            }
        }
    }
    
    func instantiateViewController(with viewModel: TableViewModel, title: String) {
        
        let viewController = ViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.title = title
        viewController.coordinator = self
        push(viewController, animated: true)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
}
