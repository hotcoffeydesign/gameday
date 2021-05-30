//
//  ApiManager.swift
//  Speed Shopper
//
//  Created by mac on 13/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import ObjectMapper

protocol WebServiceDelegate {
    func success_serverResponse(data: Any, actionStr : String)
    func failure_serverResponse(data: Any, actionStr : String)
}
class APIManager{
    static var sharedManager: APIManager{
        struct wrapper{
            static let sharedManager = APIManager()
        }
        return wrapper.sharedManager
    }
    
    lazy fileprivate var userDefaults: UserDefaults = {
        return UserDefaults.standard
    }()
    
    var apiManagerDelegate:APIManagerDelegate?
    
}



