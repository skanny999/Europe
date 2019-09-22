//
//  CountriesViewModel.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

class CountriesViewModel: TableViewModel {    

    private var countries: [Country]
    private var countryItems = [CountryItem]()
    private let dataProvider: DataProvider
    
    init(with countries: [Country], provider: DataProvider = DataProvider()) {
        
        self.dataProvider = provider
        self.countries = countries
        countryItems = countries.map { CountryItem(with: $0) }
        updateCountries()
    }
    
    private func configureCountryItems(with countries: [Country]) {
        self.countries = countries
        countryItems = countries.map { CountryItem(with: $0) }
    }
    
    func updateCountries() {
        
        dataProvider.getCountries { (countriesResult) in
            
            switch countriesResult {
                
            case .failure(let error):
                if self.countries.isEmpty {
                    print(error)
                }
                
            case .success(let updatedCountries):
                if self.countries != updatedCountries {
                    self.countries = updatedCountries
                    self.countryItems = self.countries.map { CountryItem(with: $0) }
                    self.update(nil)
                }
            }
        }
    }
    
    var update: (CountryError?) -> Void = { _ in }
    
    var title: String {
        
        return "Countries"
    }
    
    var rowCount: Int {
        
        return countryItems.count
    }
    
    func item(at indexPath: IndexPath) -> CellViewModel {
        
        return countryItems[indexPath.row]
    }
    
    func destinationViewModel(for indexPath: IndexPath) -> TableViewModel? {
        
        let selectedCountry = countries[indexPath.row]
        return CountryViewModel(with: selectedCountry)
    }
}


struct CountryItem: CellViewModel {
    
    var identifier: String
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(with country: Country) {
        
        self.imageData = country.flagData as Data?
        self.title = country.name ?? ""
        self.identifier = CountryCell.identifier
    }
}
