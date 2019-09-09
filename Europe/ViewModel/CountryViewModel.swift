//
//  CountryViewModel.swift
//  Europe
//
//  Created by Riccardo on 09/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct CountryViewModel: TableViewModel {
    
    init(with country: Country) {
        
        cellItems.append(FlagCellItem(with: country))
        cellItems.append(NameCellItem(with: country))
        cellItems.append(CapitalCellItem(with: country))
        cellItems.append(PopulationCellItem(with: country))
    }
    
    private var cellItems = [CellItem]()
    
    var rowCount: Int {
        
        return 4
    }
    
    func item(at indexPath: IndexPath) -> CellItem {

        return cellItems[indexPath.row]
    }
}


struct FlagCellItem: CellItem {
    
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(with country: Country) {
        
        self.imageData = country.flagData as Data?
    }
}

struct NameCellItem: CellItem {
    
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(with country: Country) {
        
        self.title = "Name"
        self.body = country.name
    }
}

struct CapitalCellItem: CellItem {
    
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(with country: Country) {
        
        self.title = "Capital"
        self.body = country.capital
    }
}

struct PopulationCellItem: CellItem {
    
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(with country: Country) {
        
        self.title = "Population"
        self.body = country.population.stringValue
    }
}
