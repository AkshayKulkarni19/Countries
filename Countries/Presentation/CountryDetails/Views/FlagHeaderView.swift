//
//  FlagHeaderView.swift
//  Countries
//
//  Created by Akshay Kulkarni on 18/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

class FlagHeaderView: UIView {

    @IBOutlet weak var flagImage: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func configureImage(from url: String) {
        flagImage.cacheImage(urlString: url)
    }

}
