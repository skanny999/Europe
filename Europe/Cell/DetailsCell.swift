//
//  DetailsCell.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell, CellLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var item: CellViewModel? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.title
            bodyLabel.text = item.body
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
    }
    
}
