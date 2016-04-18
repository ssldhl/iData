//
//  ToDoCellTableViewCell.swift
//  iData
//
//  Created by Sushil Dahal on 4/18/16.
//  Copyright © 2016 Sushil Dahal. All rights reserved.
//

import UIKit

typealias ToDoCellDidTapButtonHandler = () -> ()

class ToDoCellTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var didTapButtonHandler: ToDoCellDidTapButtonHandler?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: -
    // MARK: View Methods
    private func setupView() {
        let imageNormal = UIImage(named: "button-done-normal")
        let imageSelected = UIImage(named: "button-done-selected")
        
        doneButton.setImage(imageNormal, forState: .Normal)
        doneButton.setImage(imageNormal, forState: .Disabled)
        doneButton.setImage(imageSelected, forState: .Selected)
        doneButton.setImage(imageSelected, forState: .Highlighted)
        doneButton.addTarget(self, action: #selector(ToDoCellTableViewCell.didTapButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    // MARK: -
    // MARK: Actions
    func didTapButton(sender: AnyObject) {
        if let handler = didTapButtonHandler {
            handler()
        }
    }

}
