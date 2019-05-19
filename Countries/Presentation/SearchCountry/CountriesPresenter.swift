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
    func clearCountries()
    func fetchCountriesOffline(with Searchtext: String)
}

class CountriesPresenterImpl: CountriesPresenter {
    
    let fetchCountriesUseCase: FetchCountriesUseCase?
    let countriesView: CountriesView
    var countries = [CountryInfo]()
    var countriesFromDB = [CountryInfo]()
    init(fetchCountriesUseCase: FetchCountriesUseCase, countriesVC: CountriesView) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.countriesView = countriesVC
    }
    
    func getNumberOfCountries() -> Int {
        return countries.count
    }
    
    func clearCountries() {
        countries.removeAll()
        countriesView.reloadData()
    }
    
    func fetchCountries(with searchText: String) {
        countriesView.showIndicator()
        fetchCountriesUseCase?.fetchCountriesFromService(with: searchText, completion: { [weak self] (countriesList) in
            switch countriesList{
            case .success(let countriesInfo):
                self?.countries = countriesInfo
            case .failure(let error):
                print(error)
            }
            self?.countriesView.reloadData()
            self?.countriesView.hideIndicator()
        })
        
    }
    
    func fetchCountriesFromDB() {
        countriesView.showIndicator()
        fetchCountriesUseCase?.fetchAllCountriesFromDB(completion: { [weak self] (countryInfoList) in
            switch countryInfoList{
            case .success(let countriesInfo):
                self?.countries = countriesInfo
                self?.countriesFromDB = countriesInfo
            case .failure(let error):
                print(error)
            }
            self?.countriesView.reloadData()
            self?.countriesView.hideIndicator()
        })
    }
    
    func fetchCountriesOffline(with Searchtext: String) {
        countriesView.showIndicator()
        countries.removeAll()
        if !Searchtext.isEmpty {
            countries = countriesFromDB.filter { country in
                if let name =  country.name {
                    return name.lowercased().contains(Searchtext.lowercased())
                }
                return false
            }
        } else {
            countries = countriesFromDB
        }
        self.countriesView.reloadData()
        self.countriesView.hideIndicator()
    }
    
    func getCountry(at index: Int) -> CountryInfo {
        
        return self.countries[index]
    }
}
