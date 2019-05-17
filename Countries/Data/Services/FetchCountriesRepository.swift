//
//  FetchCountriesRepository.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol FetchCountriesRepository {
    
    func fetchCountriesFromService(with searchText: String, completion: @escaping contriesResponseCompletion)
}

class FetchCountriesRepositoryImpl: FetchCountriesRepository {
    
    let service: FetchCountriesService?
    
    init(service: FetchCountriesService) {
        self.service = service
    }
    
    func fetchCountriesFromService(with searchText: String, completion: @escaping contriesResponseCompletion) {
        service?.fetchCountriesFromJSON(withSearchText: searchText, completion: completion)
    }

}
