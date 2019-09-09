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
    
    private var countryItems = [CountryItem]()
    
    init(with countries: [Country]) {
        
        countryItems = countries.map { CountryItem(with: $0)}
    }
    
    var rowCount: Int {
        return countryItems.count
    }
    
    func item(at indexPath: IndexPath) -> CellItem {
        return countryItems[indexPath.row]
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
