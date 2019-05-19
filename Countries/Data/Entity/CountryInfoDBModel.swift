//
//  CountryInfoDBModel.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import RealmSwift

class CountryInfoDBModel: Object{
    @objc dynamic var name: String?
    var callingCodesList: List<String> = List<String>()
    @objc dynamic var capital: String?
    @objc dynamic var region: String?
    @objc dynamic var subregion: String?
    var timezones: List<String> =  List<String>()
    var currencies: List<CurrenciesInCountryDB> = List<CurrenciesInCountryDB>()
    var languages: List<LanguagesInCountryDB> = List<LanguagesInCountryDB>()
    @objc dynamic var flag : String?
    @objc dynamic var numericCode: String?
    
    override static func primaryKey() -> String? { return "name" }
    
    func populateData(name : String?, callingCodes: List<String>, capital: String?, region: String?, subregion: String?, timezones : List<String>?, currencies : List<CurrenciesInCountryDB>?, languages : List<LanguagesInCountryDB>?, flag : String?) {
        DatabaseCore.sharedInstance.write {
            
            self.name = name
            
            self.callingCodesList = callingCodes
            
            self.capital = capital
            self.region = region
            self.subregion = subregion
            if let timezones = timezones {
                self.timezones = timezones
            }
            if let currencies = currencies{
                self.currencies = currencies
            }
            if let languages = languages{
                self.languages = languages
            }
            self.flag = flag
        }
    }
}

class CurrenciesInCountryDB: Object {
    @objc dynamic var name: String?
    @objc dynamic var symbol: String?
    
    func populateDate(name: String?, symbol: String?) {
        self.name = name
        self.symbol = symbol
    }
}

class LanguagesInCountryDB : Object {
    @objc dynamic var name : String?
    @objc dynamic var nativeName : String?
    
    func populateDate(name: String?, nativeName: String?) {
        self.name = name
        self.nativeName = nativeName
    }
}
