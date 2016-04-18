//
//  ToDoCellTableViewCell.swift
//  iData
//
//  Created by Sushil Dahal on 4/18/16.
//  Copyright © 2016 Sushil Dahal. All rights reserved.
//

import UIKit

class ToDoCellTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
