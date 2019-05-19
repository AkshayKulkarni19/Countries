//
//  Constants.swift
//  Contries
//
//  Created by Akshay Kulkarni on 14/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

struct APIUrlsConstant {
    
    private static let baseURL = "https://restcountries.eu"
    private static let version = "/rest/v2"
    
    static let baseURLWithVer = baseURL + version
    
    struct CountryNameUrl {
        private static let name = "/name/"
        static let url = baseURLWithVer + name
    }
    
}

struct AppNetworkListenerNotifications {
    static var internetAvailableNotification = "InternetIsAvailable"
    static var internetNotAvailableNotification = "InternetIsNotAvailable"
}
