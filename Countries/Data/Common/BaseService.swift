//
//  BaseService.swift
//  Contries
//
//  Created by Akshay Kulkarni on 14/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import Alamofire

typealias APIResult = Result

class BaseService: SessionDelegate {
    
    // Define the alamofire session manager
    private var requestManager: SessionManager?
    
    // defines data request
    var dataRequest: DataRequest?
    
    typealias ResponseCompletion<T: Decodable> = (T?, _ error: Error?, _ data: Data?) -> Void
    
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        requestManager = SessionManager(configuration: configuration, delegate: self, serverTrustPolicyManager: nil)
        
    }
    
    // loads data from URL
    final func loadData<T: Decodable>(type model: T.Type,
                                      url: URL,
                                      method: HTTPMethod,
                                      parameters: [String: Any]?,
                                      headers: [String: String]? = nil,
                                      completion:@escaping ResponseCompletion<T>) {
        
        dataRequest = requestManager?.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseJSON { responseJson in

                Logger.log(message: "GET " + (responseJson.request?.url?.absoluteString ?? ""), messageType: .debug)
                
                do {
                    guard let data = responseJson.data, responseJson.result.error == nil
                        else {
                            Logger.log(message: "Error", messageType: .error)
                            completion(nil, responseJson.result.error, nil)
                            return
                    }
                    
                    if let json = responseJson.result.value as? [[String: Any?]] {
                        Logger.log(message: json.description, messageType: .debug)
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    
                    
                    completion(responseModel, nil, data)
                    
                } catch let error {
//                    Logger.log(message: error.localizedDescription, messageType: .error)
                    completion(nil, error as NSError, nil)
                }
        }
    }
    
    func cancelRequest() {
        dataRequest?.cancel()
        Logger.log(message: "Data Request is cancelled", messageType: .debug)
    }
    
}
