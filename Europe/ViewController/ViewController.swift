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
    func country(at indexPath: IndexPath) -> Country?
}

extension TableViewModel {
    
    func country(at indexPath: IndexPath) -> Country? {
        return nil
    }
}

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: Coordinator?
    
    var viewModel: TableViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setDelegates()
        configureBackButton()
        tableView.separatorStyle = .none
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
    
    private func configureBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
            
        case is CountryViewModel:
            let cellItem = viewModel?.item(at: indexPath)
            switch cellItem {
            case is FlagCellItem:
                let flagCell = tableView.dequeueReusableCell(withIdentifier: FlagCell.identifier) as? FlagCell
                flagCell?.item = cellItem
                return flagCell ?? UITableViewCell()
            default:
                let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier) as? DetailsCell
                detailCell?.item = cellItem
                return detailCell ?? UITableViewCell()
            }
        
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel is CountriesViewModel {
            
            if let country = viewModel?.country(at: indexPath) {
               coordinator?.showDetail(for: country)
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    
    
    
    
    
    
    
    
}

