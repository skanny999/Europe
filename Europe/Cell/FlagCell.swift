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
    
    var item: CellViewModel? {
        didSet {
            guard let flagItem = item else { return }
            flagImageView.setFlagImage(with: flagItem.imageData)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
    }

    
}
