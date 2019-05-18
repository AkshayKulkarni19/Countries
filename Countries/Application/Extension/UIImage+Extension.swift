//
//  UIImage+Extension.swift
//  Countries
//
//  Created by Akshay Kulkarni on 18/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func cacheImage(urlString: String) {
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                let svgImage = SVGKImage(contentsOf: url)
                //temp ugly solution as app is crashing for this url
                if urlString != "https://restcountries.eu/data/shn.svg", let img = svgImage?.uiImage {
                    imageCache.setObject(img, forKey: urlString as NSString)
                    self.image = svgImage?.uiImage
                }
            }
        }
    }
}
