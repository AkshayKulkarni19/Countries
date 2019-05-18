//
//  SaveCountryRepository.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol SaveCountryRepository {
    func saveCountryInDB(countryToSave: CountryInfoDBModel)
}

class SaveCountryRepositoryImpl: SaveCountryRepository {
    
    let service: SaveCountryInDBService?
    
    init(service: SaveCountryInDBService) {
        self.service = service
    }
    
    func saveCountryInDB(countryToSave: CountryInfoDBModel) {
        service?.saveCountryInDB(countryToSave: countryToSave)
    }
}
