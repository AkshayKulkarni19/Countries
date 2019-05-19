//
//  CountryUIMapper.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

class CountryUIMapper {
    
    static func convertUIModel(countryResponse: [CountryResponse]) -> [CountryInfo] {
        
        var currenciesInCountry = [CurrenciesInCountry]()
        var laguagesInCountry = [LanguagesInCountry]()
        var countriesInfo = [CountryInfo]()
        
        for country in countryResponse {
            
            if let currencies = country.currencies {
                for currency in currencies{
                    let currencyInCountry = CurrenciesInCountry(name: currency.name, symbol: currency.symbol)
                    currenciesInCountry.append(currencyInCountry)
                }
            }
            
            if let languages = country.languages{
                for language in languages {
                    let languageInCountry = LanguagesInCountry(name: language.name, nativeName: language.nativeName)
                    laguagesInCountry.append(languageInCountry)
                }
            }
            
            let countryInfo = CountryInfo.init(name: country.name, callingCodes: country.callingCodes ?? [String](), capital: country.capital, region: country.region, subregion: country.subregion, timezones: country.timezones ?? [String](), currencies: currenciesInCountry, languages: laguagesInCountry, flag: country.flag, flagSavedPath: nil)
            countriesInfo.append(countryInfo)
        }
        
        return countriesInfo
    }
    
    static func convertDBToUI(countryResponse: [CountryInfoDBModel]) -> [CountryInfo] {
        
        var currenciesInCountry = [CurrenciesInCountry]()
        var laguagesInCountry = [LanguagesInCountry]()
        var countriesInfo = [CountryInfo]()
        
        for country in countryResponse {
            var savedFilePath: String?
            for currency in country.currencies{
                let currencyInCountry = CurrenciesInCountry(name: currency.name, symbol: currency.symbol)
                currenciesInCountry.append(currencyInCountry)
            }
            
            for language in country.languages {
                let languageInCountry = LanguagesInCountry(name: language.name, nativeName: language.nativeName)
                laguagesInCountry.append(languageInCountry)
            }
            if let filePath = country.flag, let fileName = URL(string: filePath)?.lastPathComponent {
                savedFilePath = ImageManager.getImageDirectoryPathName(for: fileName)
            }
            
            let countryInfo = CountryInfo(name: country.name, callingCodes: Array(country.callingCodesList), capital: country.capital, region: country.region, subregion: country.subregion, timezones: Array(country.timezones), currencies: currenciesInCountry, languages: laguagesInCountry, flag: country.flag, flagSavedPath: savedFilePath)
            countriesInfo.append(countryInfo)
        }
        
        return countriesInfo
    }
    
    
    static func convertUIToDB(country: CountryInfo) -> CountryInfoDBModel {
        
        var currenciesInCountry = [CurrenciesInCountryDB]()
        var laguagesInCountry = [LanguagesInCountryDB]()
            
        if let currencies = country.currencies {
            for currency in currencies{
                let currencyInCountry = CurrenciesInCountryDB()
                currencyInCountry.populateDate(name: currency.name, symbol: currency.symbol)
                currenciesInCountry.append(currencyInCountry)
            }
        }
        
        if let languages = country.languages{
            for language in languages {
                let languageInCountry = LanguagesInCountryDB()
                languageInCountry.populateDate(name: language.name, nativeName: language.nativeName)
                laguagesInCountry.append(languageInCountry)
            }
        }
        
        let callingCodes = DatabaseCore.convertToListFromArray(country.callingCodes)
        let timezones = DatabaseCore.convertToListFromArray(country.timezones)
        let currencies = DatabaseCore.convertToListFromArray(currenciesInCountry)
        let laguages = DatabaseCore.convertToListFromArray(laguagesInCountry)
        let countryInfo = CountryInfoDBModel()
        countryInfo.populateData(name: country.name, callingCodes: callingCodes, capital: country.capital, region: country.region, subregion: country.subregion, timezones: timezones, currencies: currencies, languages: laguages, flag: country.flag)
        
        return countryInfo
    }
}
