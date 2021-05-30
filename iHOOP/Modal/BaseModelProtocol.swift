//
//  BaseModelProtocol.swift
//  Speed Shopper
//
//  Created by mac on 13/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import ObjectMapper

protocol BaseModelProtocol: Mappable {
    associatedtype Object
    var success : Any? {get set}
    var msg : String? {get set}
    var err : String? {get set}
    var msgCode : Any? {get set}
    var object : Object? {get set}
}

struct UserModel : Mappable {
    
    var parent_id: Any?
    var child_id : Any?
    var msg : String?
    var msgCode : Any?
    var dictype : [String : String]?
    var name: String!
    var dob: String!
    var email: String!
    var longitude: String!
    var contact: String!
    var device_type: String!
    var device_token: String!
    var gender: String!
    var image: String!
    var latitude: String!
    
    var isSuccess: Bool{
        guard let status = self.msgCode else{
            return false
        }
        let statusInt = status as! Int
        if statusInt == 1 {
            return true
        }else {
            return false
        }
    }
    init?(map: Map) {}
    init() {}
    mutating func mapping(map: Map) {
        child_id       <- map["id"]
        parent_id       <- map["parent_id"]
        msg           <- map["message"]
        msgCode           <- map["msg_code"]
        dictype       <- map["userData"]
        dob             <- map["dob"]
        name                        <- map["name"]
        email           <- map["email"]
        gender              <- map["gender"]
        image               <- map["image"]
        contact         <- map["contact"]
        latitude         <- map["latitude"]
        longitude         <- map["longitude"]
    }
}

struct UniversalModel<T: Mappable> : BaseModelProtocol {
    var err: String?
    
    
    
    //struct UniversalModel: Mappable {
    //var object :Mappable
    
    var object: UserModel?
    var success : Any?
    var msg : String?
    var msgCode : Any?
    var dictype : [String : String]?
    
    
    var isSuccess: Bool{
        guard let status = self.msgCode else{
            return false
        }
        let statusInt = status as! Int
        if statusInt == 1 {
            return true
        }else {
            return false
        }
    }
    init?(map: Map) {}
    init() {}
    mutating func mapping(map: Map) {
        success       <- map["status"]
        msg           <- map["message"]
        object           <- map["data"]
        msgCode           <- map["msg_code"]
        dictype       <- map["userData"]
    }
}
struct BaseModel<T: Mappable> : BaseModelProtocol {
    var msgCode: Any?
    
    var success: Any?
    var msg: String?
    var business_name_ios: String?
    var err: String?
    var object: T?
    var data: T?
    var isSuccess : Bool{
        guard let status = self.success else{
            return false
        }
        let statusInt = status as! Int
        if statusInt == 200 {
            return true
        }
        else {
            return false
        }
    }
    var isVerify: Bool {
        guard let str2 = self.success else{return false}
        if "\(str2)" == "400" {
            return true
        }else{
            return false
        }
    }
    
    init?(map: Map) {}
    init() {}
    mutating func mapping(map: Map) {
        success       <- map["status"]
        msg           <- map["message"]
        err           <- map["error"]
        object        <- map["object"]
        data          <- map["data"]
        business_name_ios  <- map["business_name_ios"]
    }
}
struct BaseListModel<T: Mappable>: BaseModelProtocol {
    var msgCode: Any?
    
    var success: Any?
    var msg: String?
    var imgURL: String?
    var type: String?
    var err: String?
    var object: [T]?
    var data: [T]?
    var path: String?
    
    init(){}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        success     <- map["status"]
        msg         <- map["message"]
        imgURL      <- map["Image_url"]
        err         <- map["error"]
        object      <- map["output"]
        data        <- map["data"]
        type        <- map["type"]
        path        <- map["path"]
        
    }
    var isSuccess: Bool {
        guard let status = self.success else{
            return false
        }
        let statusInt = status as! Int
        if statusInt == 200 {
            return true
        }
        else {
            return false
        }
    }
    var isVerify: Bool {
        guard let str2 = self.success else{return false}
        if "\(str2)" == "400" {
            return true
        }else {
            return false
        }
    }
}
struct LoginModel : Mappable {
    var id:String!
    var token:String!
    var code:String!
    var is_active:String!
    var UserName: String!
    var Password: String!
    var Email:String!
    var fname:String!
    var lname:String!
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        id           <- map["id"]
        token            <- map["token"]
        code           <- map["code"]
        is_active           <- map["is_active"]
        UserName           <- map["username"]
        Password            <- map["password"]
        Email           <- map["email"]
        fname           <- map["fname"]
        lname            <- map["lname"]
    }
}

struct PlayerDetail : Mappable {
    var player_id:String!
    var user_id:String!
    var hashID:String!
    var fname:String!
    var lname: String!
    var image: String!
    var created_at:String!
    var updated_at:String!
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        player_id           <- map["player_id"]
        user_id            <- map["user_id"]
        hashID           <- map["hashID"]
        fname           <- map["fname"]
        lname           <- map["lname"]
        image            <- map["image"]
        
    }
}
struct PlayerSummeryModel : Mappable {
    
    var id:String!
    var hashID:String!
    var PlayerID:String!
    var TotalGame:String!
    var UserID:String!
    var FT_Hit: String!
    var FT_Mis: String!
    var FG_Hit:String!
    var FG_Mis:String!
    var Three_Hit:String!
    var Three_Mis:String!
    var Def_Reb:String!
    var Off_Reb:String!
    var To_Count:String!
    var Stl_Count:String!
    var Asst_Count:String!
    var Block_Count:String!
    var Win_Count:String!
    var Loss_Count:String!
    
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map)
    {
        id           <- map["id"]
        hashID            <- map["hashID"]
        PlayerID           <- map["player_id"]
        TotalGame           <- map["total_game"]
        UserID           <- map["user_id"]
        FT_Hit            <- map["ft_H"]
        FT_Mis           <- map["ft_M"]
        FG_Hit           <- map["fg_H"]
        FG_Mis            <- map["fg_M"]
        Three_Hit           <- map["three_pt_H"]
        Three_Mis           <- map["three_pt_M"]
        Def_Reb            <- map["dreb"]
        Off_Reb           <- map["oreb"]
        To_Count           <- map["to1"]
        Stl_Count            <- map["stl"]
        Asst_Count           <- map["asst"]
        Block_Count           <- map["blk"]
        Win_Count            <- map["win"]
        Loss_Count           <- map["loss"]
    }
}
