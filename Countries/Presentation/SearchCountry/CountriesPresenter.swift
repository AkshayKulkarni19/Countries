//
//  CountriesPresenter.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CountriesPresenter {
    func getNumberOfCountries() -> Int
    func fetchCountries(with searchText: String)
    func fetchCountriesFromDB()
    func getCountry(at index: Int) -> CountryInfo
}

class CountriesPresenterImpl: CountriesPresenter {
    
    let fetchCountriesUseCase: FetchCountriesUseCase?
    let countriesView: CountriesView
    var countries = [CountryInfo]()
    init(fetchCountriesUseCase: FetchCountriesUseCase, countriesVC: CountriesView) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.countriesView = countriesVC
    }
    
    func getNumberOfCountries() -> Int {
        return countries.count
    }
    
    func fetchCountries(with searchText: String) {
        
        fetchCountriesUseCase?.fetchCountriesFromService(with: searchText, completion: { [weak self] (countriesList) in
            switch countriesList{
            case .success(let countriesInfo):
                self?.countries = countriesInfo
            case .failure(let error):
                print(error)
            }
            self?.countriesView.reloadData()
        })
        
    }
    
    func fetchCountriesFromDB() {
        fetchCountriesUseCase?.fetchAllCountriesFromDB(completion: { [weak self] (countryInfoList) in
            switch countryInfoList{
            case .success(let countriesInfo):
                self?.countries = countriesInfo
            case .failure(let error):
                print(error)
            }
            self?.countriesView.reloadData()
        })
    }
    
    func getCountry(at index: Int) -> CountryInfo {
        return self.countries[index]
    }
}
