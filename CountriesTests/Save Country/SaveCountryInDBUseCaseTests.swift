//
//  SaveCountryInDBUseCaseTests.swift
//  CountriesTests
//
//  Created by Akshay Kulkarni on 5/18/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import XCTest
@testable import Countries

class SaveCountryInDBUseCaseTests: BaseTestCase {
    
    var saveCountryInDBUseCase : SaveCountryInDBUseCase?
    var fetchCountriesUseCase : FetchCountriesUseCase?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    override func configure() {
        let saveCountryService = SaveCountryInDBServiceImpl()
        let saveCountryRepository = SaveCountryRepositoryImpl(service: saveCountryService)
        saveCountryInDBUseCase = SaveCountryInDBUseCaseImpl(repository: saveCountryRepository)
        
        let fetchCountriesService = FetchCountriesServiceStub()
        let fetchCountriesRepository = FetchCountriesRepositoryImpl(service: fetchCountriesService)
        fetchCountriesUseCase = FetchCountriesUseCaseImpl(repository: fetchCountriesRepository)
    }
    
    func testSaveAndFetchCountryToDB() {
        
        let expectation = XCTestExpectation(description: "result closure triggered")
        
        let currencies = [CurrenciesInCountry(name: "CVE", symbol: "Esc")]
        let languages = [LanguagesInCountry(name: "Portuguese", nativeName: "Português")]
        
        let country = CountryInfo(name: "Cabo Verde", callingCodes: ["238"], capital: "Praia", region: "Africa", subregion: "Western Africa", timezones: ["UTC-01:00"], currencies: currencies, languages: languages, flag: "https://restcountries.eu/data/cpv.svg", flagSavedPath: "cpv.svg")
        saveCountryInDBUseCase?.saveCountryInDB(countryToSave: country, image: UIImage())
        
        fetchCountriesUseCase?.fetchAllCountriesFromDB(completion: { (result) in
            switch result {
            case .success(let countries):
                
                XCTAssertEqual(countries.count, 1, "total countries count must be 1")
                XCTAssertNotNil(countries.first)
                XCTAssertEqual(countries.first!, country, "both countries must be equal")
                expectation.fulfill()
                
            case .failure(let error):
                 XCTFail(error.localizedDescription)
            }
        })
        
        wait(for: [expectation], timeout: 15)
    }
 
    func testPerformaceMeasureFetchCountryToDB() {
        
        let expectation = XCTestExpectation(description: "result closure triggered")
        
        let currencies = [CurrenciesInCountry(name: "CVE", symbol: "Esc")]
        let languages = [LanguagesInCountry(name: "Portuguese", nativeName: "Português")]
        
        let country = CountryInfo(name: "Cabo Verde", callingCodes: ["238"], capital: "Praia", region: "Africa", subregion: "Western Africa", timezones: ["UTC-01:00"], currencies: currencies, languages: languages, flag: "https://restcountries.eu/data/cpv.svg", flagSavedPath: "cpv.svg")
        saveCountryInDBUseCase?.saveCountryInDB(countryToSave: country, image: UIImage())
        
        measure {
            fetchCountriesUseCase?.fetchAllCountriesFromDB(completion: { (result) in
                switch result {
                case .success(let countries):
                    
                    XCTAssertEqual(countries.count, 1, "total countries count must be 1")
                    expectation.fulfill()
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })
        }
        
        wait(for: [expectation], timeout: 15)
    }
}


/*
 {
 "name": "Cabo Verde",
 "topLevelDomain": [
 ".cv"
 ],
 "alpha2Code": "CV",
 "alpha3Code": "CPV",
 "callingCodes": [
 "238"
 ],
 "capital": "Praia",
 "altSpellings": [
 "CV",
 "Republic of Cabo Verde",
 "República de Cabo Verde"
 ],
 "region": "Africa",
 "subregion": "Western Africa",
 "population": 531239,
 "latlng": [
 16,
 -24
 ],
 "demonym": "Cape Verdian",
 "area": 4033,
 "gini": 50.5,
 "timezones": [
 "UTC-01:00"
 ],
 "borders": [],
 "nativeName": "Cabo Verde",
 "numericCode": "132",
 "currencies": [
 {
 "code": "CVE",
 "name": "Cape Verdean escudo",
 "symbol": "Esc"
 }
 ],
 "languages": [
 {
 "iso639_1": "pt",
 "iso639_2": "por",
 "name": "Portuguese",
 "nativeName": "Português"
 }
 ],
 "translations": {
 "de": "Kap Verde",
 "es": "Cabo Verde",
 "fr": "Cap Vert",
 "ja": "カーボベルデ",
 "it": "Capo Verde",
 "br": "Cabo Verde",
 "pt": "Cabo Verde",
 "nl": "Kaapverdië",
 "hr": "Zelenortska Republika",
 "fa": "کیپ ورد"
 },
 "flag": "https://restcountries.eu/data/cpv.svg",
 "regionalBlocs": [
 {
 "acronym": "AU",
 "name": "African Union",
 "otherAcronyms": [],
 "otherNames": [
 "الاتحاد الأفريقي",
 "Union africaine",
 "União Africana",
 "Unión Africana",
 "Umoja wa Afrika"
 ]
 }
 ],
 "cioc": "CPV"
 }
 */
