//
//  CountryCell.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell, CellLoadable {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var item: CellItem? {
        didSet {
            guard let country = item else { return }
            flagImageView.setFlagImage(with: country.imageData)
            nameLabel.text = country.title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
