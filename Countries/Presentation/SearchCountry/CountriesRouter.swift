//
//  CountriesRouter.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import UIKit

protocol CountriesRouter {
    func showDetails(of country: CountryInfo)
    func prepare(for segue: UIStoryboardSegue, sender: Any?, country: CountryInfo)
}

class CountriesRouterImpl: CountriesRouter {
    
    var viewController: CountriesViewController
    
    init(viewController: CountriesViewController) {
        self.viewController = viewController
    }
    
    func showDetails(of country: CountryInfo){
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?, country: CountryInfo) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case "showCountryDetails":
            if let destinationViewController = segue.destination as?
                CountryDetailsViewController {
                destinationViewController.configurator = CountryDetailsConfiguratorImpl(countryInfo: country)
            }
            
        default:
            return
        }
    }
}
