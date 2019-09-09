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
    
    weak var coordinator: Coordinator?
    
    var viewModel: TableViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.rowCount)
    }


}

