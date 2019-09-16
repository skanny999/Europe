//
//  CountriesViewModel.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

struct CountriesViewModel: TableViewModel {

    private let countries: [Country]
    private var countryItems = [CountryItem]()
    
    init(with countries: [Country]) {
        
        self.countries = countries
        countryItems = countries.map { CountryItem(with: $0) }
    }
    
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
