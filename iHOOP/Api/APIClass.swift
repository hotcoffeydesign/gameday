//
//  APIClass.swift
//  STN
//
//  Created by User on 21/08/17.
//  Copyright © 2017 Ajayy. All rights reserved.
//

import Foundation
import ObjectMapper


protocol APIManagerDelegate {
    
    func compilation_Success(data:Any, check:String!)
    func compilation_Error(data:Any, check:String!)
    
    }

extension APIManager{
    
    func call_getAPI(dataDict: [String:Any], action:String!) {
        let path1 = ServerManager.sharedManager.clientServer.path + action
        let request = NetworkRequestResource(path: path1, method: .get, param: dataDict)
        
        SendNetworkRequest(request_1: request, action_1: action)
    }
    
    func SendNetworkRequest(request_1: NetworkRequestResource, action_1:String!) {
        Network.networkRequest(request_1){
            (resultState) in
            switch resultState {
            case .success(let baseModel):
                self.apiManagerDelegate?.compilation_Success(data: baseModel, check: action_1)
                break
            case .failure(let error):
                self.apiManagerDelegate?.compilation_Error(data: error , check: action_1)
                break
            }
        }
    }
    func call_postAPI(dataDict: [String:Any], action:String!) {
        let path1 = ServerManager.sharedManager.clientServer.path + action
        let request = NetworkRequestResource(path: path1, method: .post, param: dataDict)
        SendNetworkRequest(request_1: request, action_1: action)
    }
    func call_uploadAPI(dataDict: [String:Any], action:String!) {
        let path1 = ServerManager.sharedManager.clientServer.path + action
        let request = NetworkRequestResource(path: path1, method: .post, param: dataDict)
        
        sendUploadRequest(request_1: request, action_1: action)
    }
    
    func sendUploadRequest(request_1: NetworkRequestResource, action_1:String!) {
        Network.uploadData(request_1){
            (resultState) in
            switch resultState {
            case .success(let baseModel):
                self.apiManagerDelegate?.compilation_Success(data: baseModel, check: action_1)
                break
            case .failure(let error):
                self.apiManagerDelegate?.compilation_Error(data: error , check: action_1)
                break
            }
        }
    }
    
    func call_API_ForUpload(dataDict: [String:Any], action:String!, GET_or_POST: String)
    {
        let path1 = ServerManager.sharedManager.clientServer.path + action
        let request = NetworkRequestResource(path: path1, method: GET_or_POST == "GET" ? .get : .post, param: dataDict)
        
        sendUploadRequest(request_1: request, action_1: action)
    }
    
    func callSpotifyGetAPI(dataDict: [String:Any], action:String!) {
        let path1 = "https://api.spotify.com/v1/browse/" + action
        let request = NetworkRequestResource(path: path1, method: .get, param: dataDict)
        SendNetworkRequest(request_1: request, action_1: action)
    }
  
    
}
