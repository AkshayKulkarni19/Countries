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
}

struct CurrenciesInCountry {
    let name : String?
    let symbol : String?
}

struct LanguagesInCountry {
    let name : String?
    let nativeName : String?
}
