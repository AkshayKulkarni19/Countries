//
//  FlagTableViewCell.swift
//  Countries
//
//  Created by Akshay Kulkarni on 18/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

class FlagTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureImage(from url: String) {
        flagImage.cacheImage(urlString: url)
    }
    
}
