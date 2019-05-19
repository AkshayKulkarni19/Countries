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
    
    func configureImage(from country: CountryInfo) {
        if let savedPath = country.flagSavedPath {
            let fileName = URL(string: savedPath)?.lastPathComponent
            self.flagImage.image = ImageManager.getImage(with: fileName ?? "")
        } else {
            if let url = country.flag {
                flagImage.cacheImage(urlString: url) { (image, urlFlag) in
                    if url == urlFlag {
                        self.flagImage.image = image
                    }
                }
            }
        }
    }
}
