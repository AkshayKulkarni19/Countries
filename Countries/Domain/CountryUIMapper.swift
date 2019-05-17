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
        
        var currenciesInCountry: [CurrenciesInCountry]?
        var laguagesInCountry: [LanguagesInCountry]?
        var countryInfo = [CountryInfo]()
        
        for country in countryResponse {
            
            if let currencies = country.currencies {
                for currency in currencies{
                    currenciesInCountry?.append(CurrenciesInCountry.init(name: currency.name, symbol: currency.symbol))
                }
            }
            
            if let languages = country.languages{
                for language in languages {
                    
                    laguagesInCountry?.append(LanguagesInCountry.init(name: language.name, nativeName: language.nativeName))
                }
            }
            
            countryInfo.append( CountryInfo.init(name: country.name, callingCodes: country.callingCodes, capital: country.capital, region: country.region, subregion: country.subregion, timezones: country.timezones, currencies: currenciesInCountry, languages: laguagesInCountry, flag: country.flag))
        }
        
        return countryInfo
    }
}
