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
        countryItems = countries.map { CountryItem(with: $0)}
    }
    
    var rowCount: Int {
        
        return countryItems.count
    }
    
    func item(at indexPath: IndexPath) -> CellItem {
        
        return countryItems[indexPath.row]
    }
    
    func country(at indexPath: IndexPath) -> Country? {
        
        return countries[indexPath.row]
    }
    
    
}


struct CountryItem: CellItem {    
    
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(with country: Country) {
        
        self.imageData = country.flagData as Data?
        self.title = country.name ?? ""
    }
}
