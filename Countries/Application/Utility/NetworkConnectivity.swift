//
//  NetworkConnectivity.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import Alamofire

class NetworkConnectivity {
    private let networkReachabilityManager: NetworkReachabilityManager?
    
    static let sharedInstance = NetworkConnectivity()
    
    private init() {
        networkReachabilityManager = NetworkReachabilityManager()
    }
    
    /**
     * @discussion returns if network connectivity is available
     * @return Bool
     */
    func isConnectedToInternet() -> Bool {
        return networkReachabilityManager?.isReachable ?? false
    }
    
    func listenForNetworkAvailability(succesHandler: @escaping (()->Void), errorHandler: @escaping (()->Void)) {
        self.networkReachabilityManager?.listener = {status in
            switch status {
            case .notReachable, .unknown:
                Logger.log(message: "Network not reachable", messageType: .warning)
                errorHandler()
                
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                succesHandler()
            }
        }
        
        self.networkReachabilityManager?.startListening()
    }
    
    func unregisterNetworkListener() {
        self.networkReachabilityManager?.stopListening()
        self.networkReachabilityManager?.listener = nil
    }
}
