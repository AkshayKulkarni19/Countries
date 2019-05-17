//
//  Country.swift
//  Contries
//
//  Created by Akshay Kulkarni on 14/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

struct CountryResponse: Codable{
    let name : String?
    let topLevelDomain : [String]?
    let alpha2Code : String?
    let alpha3Code : String?
    let callingCodes : [String]?
    let capital : String?
    let altSpellings : [String]?
    let region : String?
    let subregion : String?
    let population : Int?
    let latlng : [Double]?
    let demonym : String?
    let area : Double?
    let gini : Double?
    let timezones : [String]?
    let borders : [String]?
    let nativeName : String?
    let numericCode : String?
    let currencies : [Currencies]?
    let languages : [Languages]?
    let translations : Translations?
    let flag : String?
    let regionalBlocs : [RegionalBlocs]?
    let cioc : String?
}

struct Currencies: Codable {
    let code : String?
    let name : String?
    let symbol : String?
}

struct Languages : Codable {
    let iso639_1 : String?
    let iso639_2 : String?
    let name : String?
    let nativeName : String?
}

struct RegionalBlocs : Codable {
    let acronym : String?
    let name : String?
    let otherAcronyms : [String]?
    let otherNames : [String]?
}

struct Translations : Codable {
    let de : String?
    let es : String?
    let fr : String?
    let ja : String?
    let it : String?
    let br : String?
    let pt : String?
    let nl : String?
    let hr : String?
    let fa : String?
}
