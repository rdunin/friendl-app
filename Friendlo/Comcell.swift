//
//  Comcell.swift
//  Friendlo
//
//  Created by Alona Demochko on 14.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

class Comcell: UITableViewCell {

    @IBOutlet var avaImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var comm: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
