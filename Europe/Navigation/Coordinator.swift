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

        let dataProvider = DataProvider()
        let storedCountries = dataProvider.storedCountries()
        let countriesViewModel = CountriesViewModel(with: storedCountries)
        instantiateViewController(with: countriesViewModel)
    }
    
    func instantiateViewController(with viewModel: TableViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let viewController = ViewController.instantiate()
            viewController.viewModel = viewModel
            viewController.title = viewModel.title
            viewController.coordinator = self
            self?.push(viewController, animated: true)
        }
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
}
