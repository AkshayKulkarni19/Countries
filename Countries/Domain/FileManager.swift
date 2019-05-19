//
//  FileManager.swift
//  Countries
//
//  Created by Akshay Kulkarni on 19/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

class ImageManager {
    
    private class func getImageDirectory() -> URL? {
        
        // get the documents directory url
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        // create the destination file url to save your image
        
        return documentsDirectory.appendingPathComponent("Images", isDirectory: true)
    }
    
    class func saveImageDocumentDirectory(image: UIImage, name: String){
        createDirectory()
        let fileName = name
        // create the destination file url to save your image
        
        if let imgDir = getImageDirectory() {
            let fileURL = imgDir.appendingPathComponent(fileName)
            
            if let data = image.pngData(),
                !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
            }
        }
    }
    
    class func getImage(with filename: String) -> UIImage? {
        
        if let imgDir = getImageDirectory() {
            let fileURL = imgDir.appendingPathComponent(filename)
            let urlStr = fileURL.path
            if FileManager.default.fileExists(atPath: urlStr) {
                return UIImage(contentsOfFile: urlStr)
            }
        }
        return nil
    }
    
    class func getImageDirectoryPathName(for fileName: String) -> String? {
        if let imgDir = getImageDirectory() {
            let fileURL = imgDir.appendingPathComponent(fileName)
            return fileURL.path
        }
        return nil
    }
    
    private class func createDirectory() {
        if let imgDir = getImageDirectory() {
            if FileManager.default.fileExists(atPath: imgDir.path) {
                print("Already dictionary created.")
            } else {
                do {
                    try FileManager.default.createDirectory(at: imgDir, withIntermediateDirectories: true, attributes: nil)
                } catch { }
            }
        }
    }
}
