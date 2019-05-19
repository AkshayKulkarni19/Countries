//
//  CountryDetailsConfigurator.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
protocol CountryDetailsConfigurator {
    func configure(viewcontroller: CountryDetailsViewController)
}

class CountryDetailsConfiguratorImpl: CountryDetailsConfigurator {
    
    private let countryInfo: CountryInfo
    init(countryInfo: CountryInfo) {
        self.countryInfo = countryInfo
    }
    
    func configure(viewcontroller: CountryDetailsViewController){
        let service = SaveCountryInDBServiceImpl()
        let repository = SaveCountryRepositoryImpl(service: service)
        let saveCountryUseCase = SaveCountryInDBUseCaseImpl(repository: repository)
        let presenter = CountryDetailsPresenterImpl(country: self.countryInfo, saveCountryUseCase: saveCountryUseCase)
        viewcontroller.presenter = presenter
    }
}

