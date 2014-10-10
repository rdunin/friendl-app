//
//  Cell.swift
//  Friendlo
//
//  Created by Alona Demochko on 07.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var titleTexts: UILabel!
    @IBOutlet var shadow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
