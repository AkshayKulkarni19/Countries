//
//  CountryDetailsTableViewCell.swift
//  Countries
//
//  Created by Akshay Kulkarni on 16/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

class CountryDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with detailVal: String, label: String) {
        detailLabel.text = label
        detailValue.text = detailVal
    }
    
}
