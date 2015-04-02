//
//  ProductCell.swift
//  MarketApi
//
//  Created by Bruno Paulino on 4/2/15.
//  Copyright (c) 2015 Bruno Paulino. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var email: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
