//
//  FetchCountriesServiceStub.swift
//  CountriesTests
//
//  Created by Akshay Kulkarni on 5/18/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
@testable import Countries

class FetchCountriesServiceStub: FetchCountriesService {
    
    func fetchCountriesFromJSON(withSearchText: String, completion: @escaping contriesResponseCompletion) {
        
        let stubGenerator = StubGenerator()
        if let data = stubGenerator.getCountriesData() {
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseModel = try jsonDecoder.decode([CountryResponse].self, from: data)
                
                completion(.success(responseModel))
                
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
        
    }
}
