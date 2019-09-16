//
//  ViewController.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

protocol TableViewModel {
    
    var title: String { get }
    var rowCount: Int { get }
    func item(at indexPath: IndexPath) -> CellViewModel
    func destinationViewModel(for indexPath: IndexPath) -> TableViewModel?
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
        
        if let cellViewModel = viewModel?.item(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier) as? CellLoadable {
            cell.item = cellViewModel
            return cell as UITableViewCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if let viewModel = viewModel?.destinationViewModel(for: indexPath) {
                
               coordinator?.pushViewController(for: viewModel)
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
    }
}

