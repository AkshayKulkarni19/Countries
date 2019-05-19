//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit
import SVGKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
//        self.flagImage.image = nil
//    }
    
    func configure(with country: CountryInfo) {
        
        countryName.text = country.name
        if let savedPath = country.flagSavedPath {
            let fileName = URL(string: savedPath)?.lastPathComponent
            self.flagImage.image = ImageManager.getImage(with: fileName ?? "")
        } else if let flagURLstr = country.flag {
            self.flagImage.cacheImage(urlString: flagURLstr) { (image, url) in
                if url == flagURLstr {
                    self.flagImage.image = image
                }
            }
//            self.flagImage.cacheImage(urlString: flagURLstr)
        }
    }
    
}
