//
//  SaveCountryInDBService.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol SaveCountryInDBService {
    func saveCountryInDB(countryToSave: CountryInfoDBModel)
}

class SaveCountryInDBServiceImpl: SaveCountryInDBService {
    
    func saveCountryInDB(countryToSave: CountryInfoDBModel) {
        DatabaseCore.sharedInstance.saveObject(countryToSave, update: true)
    }
    
}
