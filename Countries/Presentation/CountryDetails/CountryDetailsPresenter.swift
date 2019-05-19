//
//  CountryDetailsPresenter.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CountryDetailsPresenter {
    func prepareFields()
    func getNumberOfDetails() -> Int
    func getDetails(at index: Int) -> CountryDetailFieldsModel
    func getSelectedCountry() -> CountryInfo
    func saveCountry(country: CountryInfo, with image:UIImage)
}

class CountryDetailsPresenterImpl: CountryDetailsPresenter {
    
    let country: CountryInfo
//    private let countryDetailsView: CountryDetailsView
    private var countryDetailFieldsModels = [CountryDetailFieldsModel]()
    let saveCountryUseCase: SaveCountryInDBUseCase?
    
    init(country: CountryInfo, saveCountryUseCase: SaveCountryInDBUseCase) {
        self.country = country
        self.saveCountryUseCase = saveCountryUseCase
    }
    
    func prepareFields() {
        var countryDetailFieldsModel = CountryDetailFieldsModel()
        
        if let capital = country.capital {
            countryDetailFieldsModel.cellContentType = CellContentType.capital
            countryDetailFieldsModel.cellValue = capital
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
        if !country.callingCodes.isEmpty {
            countryDetailFieldsModel.cellContentType = CellContentType.callingCode
            countryDetailFieldsModel.cellValue = country.callingCodes.joined(separator: "\n")
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
        if let region = country.region {
            countryDetailFieldsModel.cellContentType = CellContentType.region
            countryDetailFieldsModel.cellValue = region
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
        if let subRegion = country.subregion {
            countryDetailFieldsModel.cellContentType = CellContentType.SubRegion
            countryDetailFieldsModel.cellValue = subRegion
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
        if !country.timezones.isEmpty {
            countryDetailFieldsModel.cellContentType = CellContentType.timeZone
            countryDetailFieldsModel.cellValue = country.timezones.joined(separator: "\n")
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
        if let languages = country.languages {
            countryDetailFieldsModel.cellContentType = CellContentType.language
            let langs = languages.compactMap{ $0.name }
            countryDetailFieldsModel.cellValue = langs.joined(separator: "\n")
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
        if let currencies = country.currencies {
            countryDetailFieldsModel.cellContentType = CellContentType.currencies
            let currency = currencies.compactMap{ $0.symbol }
            countryDetailFieldsModel.cellValue = currency.joined(separator: "\n")
            countryDetailFieldsModels.append(countryDetailFieldsModel)
        }
    }
    
    func getNumberOfDetails() -> Int {
        return countryDetailFieldsModels.count
    }
    
    func getDetails(at index: Int) -> CountryDetailFieldsModel {
        return countryDetailFieldsModels[index]
    }
    
    func getSelectedCountry() -> CountryInfo {
        return country
    }
    
    func saveCountry(country: CountryInfo, with image:UIImage) {
        saveCountryUseCase?.saveCountryInDB(countryToSave: country, image: image)
    }
    
    func saveImageInDocument(imageToSave: UIImage) {
        
    }
}
