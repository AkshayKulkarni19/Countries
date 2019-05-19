//
//  StubGenerator.swift
//  CountriesTests
//
//  Created by Akshay Kulkarni on 5/18/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
@testable import Countries

class StubGenerator {
    private func getFileContentsAsData(fileUrl: URL) -> Data? {
        if let data = try? Data.init(contentsOf: fileUrl) {
            return data
        }
        
        return nil
    }
    
    func getCountriesData() -> Data? {
        let testBundle = Bundle.init(for: type(of: self))
        
        if let fileUrl = testBundle.url(forResource: "countries", withExtension: "json") {
            return getFileContentsAsData(fileUrl: fileUrl)
        }
        return nil
    }
    
}
