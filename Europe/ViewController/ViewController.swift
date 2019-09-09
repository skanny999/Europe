//
//  ViewController.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

protocol TableViewModel {
    
    var rowCount: Int { get }
    func item(at indexPath: IndexPath) -> CellItem
}

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: Coordinator?
    
    var viewModel: TableViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setDelegates()
    }
    
    private func registerCells() {
        
        tableView.register(CountryCell.nib, forCellReuseIdentifier: CountryCell.identifier)
        tableView.register(DetailsCell.nib, forCellReuseIdentifier: DetailsCell.identifier)
        tableView.register(FlagCell.nib, forCellReuseIdentifier: FlagCell.identifier)
    }
    
    private func setDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel {
        case is CountriesViewModel:
            let countryCell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as? CountryCell
            countryCell?.item = viewModel?.item(at: indexPath)
            return countryCell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    
    
    
    
    
    
    
}

