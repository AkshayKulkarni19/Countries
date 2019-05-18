//
//  fetchContriesService.swift
//  Contries
//
//  Created by Akshay Kulkarni on 14/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

typealias contriesResponseCompletion = (APIResult<[CountryResponse]>) -> Void

protocol FetchCountriesService {
    
    func fetchCountriesFromJSON(withSearchText: String, completion: @escaping contriesResponseCompletion)
}

class FetchCountriesServiceImpl: BaseService, FetchCountriesService {
    
    func fetchCountriesFromJSON(withSearchText: String, completion: @escaping contriesResponseCompletion) {
        
        guard let url = URL(string: APIUrlsConstant.CountryNameUrl.url + withSearchText) else {
            completion(.failure(NSError(domain: "restcountries.eu", code: 45454, userInfo: nil) as Error))
            return
        }
        
        
        self.loadData(type: [CountryResponse].self,
                      url: url,
                      method: .get,
                      parameters: nil) { countryResponse, error, data in
                        guard let response = countryResponse, error == nil else {
                            completion(.failure(error!))
                            return
                        }
                        completion(.success(response))
        }
    }
    
}
