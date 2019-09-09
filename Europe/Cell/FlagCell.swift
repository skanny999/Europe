//
//  FlagCell.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

class FlagCell: UITableViewCell, CellLoadable {
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    var item: CellItem? {
        didSet {
            guard let countryItem = item else { return }
//            flagImageView.image =
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
