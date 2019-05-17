//
//  CountriesConfigurator.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

protocol CountriesConfigurator {
    func configurator(viewcontroller: CountriesViewController)
}

class CountriesConfiguratorImpl {
    
    func configurator(viewcontroller: CountriesViewController){
        let service = FetchCountriesServiceImpl()
        let repository = FetchCountriesRepositoryImpl(service: service)
        let useCase = FetchCountriesUseCaseImpl(repository: repository)
        
        let presenter = CountriesPresenterImpl(fetchCountriesUseCase: useCase, countriesVC: viewcontroller)
        viewcontroller.presenter = presenter
    }
}
