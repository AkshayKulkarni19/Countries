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
    @IBOutlet weak var flagImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with country: CountryInfo) {
        countryName.text = country.name
        if let flagURLstr = country.flag, let flagURl = URL(string: flagURLstr) {
            let svgImage = SVGKImage(contentsOf: flagURl)
            
        }
        /*if let flagURLstr = country.flag, let flagURl = URL(string: flagURLstr) {
//            let flagImageVw = UIView(SVGURL: flagURl)
            let flagImageVw = UIView(SVGURL: flagURl) { (svgLayer) in
                svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
                svgLayer.resizeToFit(self.flagImage.bounds)
            }
            flagImage.addSubview(flagImageVw)
        }*/
    }
    
}
