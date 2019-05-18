//
//  FetchCountriesUseCase.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

typealias CountryInfocompletion = (APIResult<[CountryInfo]>) -> Void

protocol FetchCountriesUseCase {
    func fetchCountriesFromService(with searchText: String, completion: @escaping CountryInfocompletion)
    func fetchAllCountriesFromDB(completion: @escaping CountryInfocompletion)
}

class FetchCountriesUseCaseImpl: FetchCountriesUseCase {
    
    private var fetchCountriesRepository: FetchCountriesRepository
    
    init(repository: FetchCountriesRepository) {
        self.fetchCountriesRepository = repository
    }
    
    func fetchCountriesFromService(with searchText: String, completion: @escaping CountryInfocompletion) {
        
        fetchCountriesRepository.fetchCountriesFromService(with: searchText) { (countryResponse) in
            switch countryResponse {
            case .success(let country):
                let countries = CountryUIMapper.convertUIModel(countryResponse: country)
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllCountriesFromDB(completion: @escaping CountryInfocompletion) {
        fetchCountriesRepository.fetchAllCountriesFromDB { (countryInfoDB) in
            switch countryInfoDB {
            case .success(let countryDB):
                let countries = CountryUIMapper.convertDBToUI(countryResponse: countryDB)
                completion(.success(countries))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
