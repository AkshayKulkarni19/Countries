//
//  CountryInfo.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

struct CountryInfo {
    let name : String?
    let callingCodes: [String]
    let capital: String?
    let region: String?
    let subregion: String?
    let timezones: [String]
    let currencies : [CurrenciesInCountry]?
    let languages : [LanguagesInCountry]?
    let flag : String?
    let flagSavedPath: String?
}

struct CurrenciesInCountry {
    let name : String?
    let symbol : String?
}

struct LanguagesInCountry {
    let name : String?
    let nativeName : String?
}

extension CountryInfo: Equatable {
    
    static func == (lhs: CountryInfo, rhs: CountryInfo) -> Bool {
        return lhs.name == rhs.name &&
            lhs.callingCodes == rhs.callingCodes &&
            lhs.capital == rhs.capital &&
            lhs.flag == rhs.flag &&
            lhs.region == rhs.region &&
            lhs.timezones == rhs.timezones &&
            lhs.languages == rhs.languages &&
            lhs.currencies == rhs.currencies &&
            lhs.subregion == rhs.subregion
    }
}

extension CurrenciesInCountry: Equatable {
    
}

extension LanguagesInCountry: Equatable {
    
}
