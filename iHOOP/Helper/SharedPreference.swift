//
//  SharedPreference.swift
//  Speed Shopper
//
//  Created by info on 14/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class SharedPreference: NSObject {
    
    fileprivate let kid  = "id___"
    fileprivate let kFName = "Fname____"
    fileprivate let kLName = "LName___"
    fileprivate let kEmail = "email____"
    fileprivate let kPassword = "password___"
    fileprivate let kUserName = "username____"
    fileprivate let kCode = "code____"
    fileprivate let kDeviceToken = "device_token___"
    fileprivate let kIsActive = "isactive___"
    
    
    
    fileprivate let defaults = UserDefaults.standard
    
    static let sharedInstance = SharedPreference()
    
    class func saveUserData(user:LoginModel){
        sharedInstance.saveUserData(user)
    }
    
    fileprivate func saveUserData(_ user: LoginModel){
        defaults.setValue(user.id , forKey: kid)
        defaults.setValue(user.Email, forKey: kEmail)
        defaults.setValue(user.UserName, forKey: kUserName)
        defaults.setValue(user.Password, forKey: kPassword)
        defaults.setValue(user.token, forKey: kDeviceToken)
        defaults.setValue(user.fname, forKey: kFName)
        defaults.setValue(user.lname, forKey: kLName)
        defaults.setValue(user.code, forKey: kCode)
        defaults.setValue(user.is_active, forKey: kIsActive)
        
        
        
        
        
        defaults.synchronize()
    }
    class func clearUserData(){
        sharedInstance.clearUserData()
    }
    
    fileprivate func clearUserData(){
        self.deleteUserData()
    }
    fileprivate func deleteUserData(){
        defaults.removeObject(forKey: kid)
        defaults.removeObject(forKey: kUserName)
        defaults.removeObject(forKey: kLName)
        defaults.removeObject(forKey: kFName)
        defaults.removeObject(forKey: kEmail)
        defaults.removeObject(forKey: kPassword)
        defaults.removeObject(forKey: kDeviceToken)
        defaults.removeObject(forKey: kCode)
        defaults.removeObject(forKey: kIsActive)
        defaults.synchronize()
    }
    
    class func getUserData() -> LoginModel{
        return sharedInstance.getUserData()
    }
    
    fileprivate  func getUserData() -> LoginModel {
        var user:LoginModel  = LoginModel()
        user.Email = defaults.value(forKey: kEmail) as? String
        user.lname = defaults.value(forKey: kLName) as? String
        user.fname = defaults.value(forKey: kFName) as? String
        user.UserName = defaults.value(forKey: kUserName ) as? String
        user.token = defaults.value(forKey: kDeviceToken ) as? String
        user.code = defaults.value(forKey: kCode) as? String
        user.is_active = defaults.value(forKey: kIsActive) as? String
        user.id = defaults.value(forKey: kid) as? String
        
        return user
    }
    //    func setCurrentLocation(lat: Double, long: Double){
    //        defaults.set(lat, forKey: kCurrentLocationLat)
    //        defaults.set(long, forKey: kCurrentLocationLong)
    //        defaults.synchronize()
    //    }
    
    //    class func getCurrentLocation() -> (lat: Double, long: Double) {
    //        return  sharedInstance.getCurrent()
    //    }
    //    func getCurrent() -> (lat: Double, long: Double){
    //        return (defaults.double(forKey: kCurrentLocationLat),  defaults.double(forKey: kCurrentLocationLong))
    //    }
    
    //    class func getCurrentUserLocation() -> (lat: String, long: String) {
    //        return  sharedInstance.getCurrentUser()
    //    }
    //    func getCurrentUser() -> (lat: String, long: String){
    ////        return (defaults.string(forKey: kCurrentLocationLat)!,  defaults.string(forKey: kCurrentLocationLong)!)
    //    }
    
    class func storeDeviceToken(_ token: String) {
        sharedInstance.setDeviceToken(token)
    }
    class func deviceToken() -> String {
        return sharedInstance.getDeviceToken() ?? ""//"device555555555555"
    }
    fileprivate func setDeviceToken(_ token: String){
        defaults.set(token, forKey: kDeviceToken);
    }
    fileprivate func getDeviceToken() -> String?{
        return defaults.value(forKey: kDeviceToken) as? String;
    }
    
    
    //    func setAppFirstInstall(){
    //        defaults.set(true, forKey: KAppFirstInstall)
    //    }
    //
    //    func getAppFirstInstall() -> Bool{
    //        return defaults.bool(forKey: KAppFirstInstall)
    //    }
    //
    
}
