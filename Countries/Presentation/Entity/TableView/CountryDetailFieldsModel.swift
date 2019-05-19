//
//  CountryDetailFieldsModel.swift
//  Countries
//
//  Created by Akshay Kulkarni on 16/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

enum CellContentType: String {
    case capital = "Capital"
    case callingCode = "CallingCode"
    case region = "Region"
    case SubRegion = "Sub Region"
    case timeZone = "Time Zone"
    case currencies = "Currencies"
    case language = "Language"
}

struct CountryDetailFieldsModel {
    
    var cellContentType: CellContentType?
    var cellValue: String?
    
}
