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
        
        let presenter = CountryDetailsPresenterImpl(country: self.countryInfo, countriesDetailsVC: viewcontroller)
        viewcontroller.presenter = presenter
    }
}

