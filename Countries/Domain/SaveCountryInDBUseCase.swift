//
//  SaveCountryInDBUseCase.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol SaveCountryInDBUseCase {
    func saveCountryInDB(countryToSave: CountryInfo, image: UIImage)
}

class SaveCountryInDBUseCaseImpl: SaveCountryInDBUseCase {
    
    private var saveCountryRepository: SaveCountryRepository
    
    init(repository: SaveCountryRepository) {
        self.saveCountryRepository = repository
    }
    
    func saveCountryInDB(countryToSave: CountryInfo, image: UIImage) {
        let url = URL(string: countryToSave.flag ?? "")
        var saveAtPath: String?
        if let name = url?.pathComponents.last {
            saveAtPath = ImageManager.saveImageDocumentDirectory(image: image, name: name)
        }
        
        let countryToSaveDB = CountryUIMapper.convertUIToDB(country: countryToSave)
        saveCountryRepository.saveCountryInDB(countryToSave: countryToSaveDB)
    }
    
}
