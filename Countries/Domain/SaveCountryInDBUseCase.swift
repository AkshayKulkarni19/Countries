//
//  SaveCountryInDBUseCase.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol SaveCountryInDBUseCase {
    func saveCountryInDB(countryToSave: CountryInfo)
}

class SaveCountryInDBUseCaseImpl: SaveCountryInDBUseCase {
    
    private var saveCountryRepository: SaveCountryRepository
    
    init(repository: SaveCountryRepository) {
        self.saveCountryRepository = repository
    }
    
    func saveCountryInDB(countryToSave: CountryInfo) {
        let countryToSaveDB = CountryUIMapper.convertUIToDB(country: countryToSave)
        saveCountryRepository.saveCountryInDB(countryToSave: countryToSaveDB)
    }
    
}
