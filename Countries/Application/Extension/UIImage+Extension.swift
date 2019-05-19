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

//extension UIImageView {
//
//    func cacheImage(urlString: String) {
//
//        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
//            self.image = imageFromCache
//            return
//        }
//
//        if let url = URL(string: urlString) {
//
//            DispatchQueue.global(qos: .userInteractive).async {
//                var svgImage:SVGKImage?
//                svgImage = SVGKImage(contentsOf: url)
////                let img = svgImage?.uiImage
//
//                //temp ugly solution as app is crashing for this url
//                if urlString != "https://restcountries.eu/data/shn.svg", let image = svgImage?.uiImage {
//                    imageCache.setObject(image, forKey: urlString as NSString)
//                    DispatchQueue.main.async {
//                        self.image = image
//                    }
//                }
//
//            }
////                let svg = SVGKImage(contentsOfFileAsynchronously: urlString, onCompletion: { (svgImage, result) in
////                    DispatchQueue.main.async {
////                        //temp ugly solution as app is crashing for this url
////                        if urlString != "https://restcountries.eu/data/shn.svg", let img = svgImage?.uiImage {
////                            imageCache.setObject(img, forKey: urlString as NSString)
////                            self.image = svgImage?.uiImage
////                        }
////                    }
////                    print("comp")
////                })
//
//
//        }
//    }
//}

extension UIImageView {
    
    func cacheImage(urlString: String, completion: @escaping (UIImage, String) -> Void) {
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .userInteractive).async {
                var svgImage:SVGKImage?
                svgImage = SVGKImage(contentsOf: url)
                
                //temp ugly solution as app is crashing for this url
                if urlString != "https://restcountries.eu/data/shn.svg", let image = svgImage?.uiImage {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completion(image, urlString)
                    }
                }
            }
        }
    }
    
    func cacheImageDownloadFromDB(urlString: String, completion: @escaping (UIImage, String) -> Void) {
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            var svgImage:SVGKImage?
            svgImage = SVGKImage(contentsOfFile: urlString)
            
            //temp ugly solution as app is crashing for this url
            if urlString != "https://restcountries.eu/data/shn.svg", let image = svgImage?.uiImage {
                imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    completion(image, urlString)
                    //                        self.image = image
                }
            }
        }
    }
}
