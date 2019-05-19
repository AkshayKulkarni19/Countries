//
//  FetchCountriesRepositoryStub.swift
//  CountriesTests
//
//  Created by Akshay Kulkarni on 5/18/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
@testable import Countries

class FetchCountriesRepositoryStub: FetchCountriesRepository {
    
    var service: FetchCountriesService
    
    init(service: FetchCountriesService) {
        self.service = service
    }
    var fetchCountriesFromServiceCalled = false
    func fetchCountriesFromService(with searchText: String, completion: @escaping contriesResponseCompletion) {
        fetchCountriesFromServiceCalled = true
        service.fetchCountriesFromJSON(withSearchText: searchText
            , completion: completion)
    }
    
    func fetchAllCountriesFromDB(completion: @escaping CountryInfoDBCompletion) {
        
    }
    
    
}
