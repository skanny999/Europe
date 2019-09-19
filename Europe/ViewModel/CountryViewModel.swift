//
//  CountryViewModel.swift
//  Europe
//
//  Created by Riccardo on 09/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct CountryViewModel: TableViewModel {
    
    private var cellItems = [CellViewModel]()
    
    init(with country: Country) {
        
        self.title = country.name ?? ""
        cellItems.append(FlagCellItem(with: country))
        cellItems.append(DetailCellItem(title: "Name", body: country.name))
        cellItems.append(DetailCellItem(title: "Capital", body: country.capital))
        cellItems.append(DetailCellItem(title: "Population", body: country.population.stringValue))
    }
    
    var title: String
    
    var rowCount: Int {
        
        return cellItems.count
    }
    
    func item(at indexPath: IndexPath) -> CellViewModel {

        return cellItems[indexPath.row]
    }
    
    func destinationViewModel(for indexPath: IndexPath) -> TableViewModel? {
        return nil
    }
}


struct FlagCellItem: CellViewModel {
    
    var imageData: Data?
    var title: String?
    var body: String?
    var identifier: String
    
    init(with country: Country) {
        
        self.imageData = country.flagData as Data?
        self.identifier = FlagCell.identifier
    }
}

struct DetailCellItem: CellViewModel {
    
    var identifier: String
    var imageData: Data?
    var title: String?
    var body: String?
    
    init(title: String, body: String?) {
        self.title = title
        self.body = body
        self.identifier = DetailsCell.identifier
    }
}



