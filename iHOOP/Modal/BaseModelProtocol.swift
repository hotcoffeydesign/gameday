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
    var name: String?
    var dob: String?
    var email: String?
    var longitude: String?
    var contact: String?
    var device_type: String?
    var device_token: String?
    var gender: String?
    var image: String?
    var latitude: String?
    
    var isSuccess: Bool{
        guard let status = self.msgCode else{
            return false
        }
        let statusInt = status as? Int
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
        let statusInt = status as? Int
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
        let statusInt = status as? Int
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
        let statusInt = status as? Int
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
    var id:String?
    var token:String?
    var code:String?
    var is_active:String?
    var UserName: String?
    var Password: String?
    var Email:String?
    var fname:String?
    var lname:String?
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
    var player_id:String?
    var user_id:String?
    var hashID:String?
    var fname:String?
    var lname: String?
    var image: String?
    var created_at:String?
    var updated_at:String?
    var game_list:[GameSeasonModal]?
    var season_list:[GameSeasonModal]?
    var game_id :String?
    var player_name:String?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        player_id           <- map["player_id"]
        user_id            <- map["user_id"]
        hashID           <- map["hashID"]
        fname           <- map["fname"]
        lname           <- map["lname"]
        image            <- map["image"]
        game_list       <- map["game_list"]
        game_id         <- map ["game_id"]
        season_list     <- map["season_list"]
        player_name     <- map["player_name"]
    }
}

struct PlayerSummeryModel : Mappable {
    
    var id:String?
    var hashID:String?
    var PlayerID:String?
    var TotalGame:Int?
    var UserID:String?
    var FT_Hit: Int?
    var FT_Mis: Int?
    var FG_Hit:Int?
    var FG_Mis:Int?
    var Three_Hit:Int?
    var Three_Mis:Int?
    var Def_Reb:Int?
    var Off_Reb:Int?
    var To_Count:Int?
    var Stl_Count:Int?
    var Asst_Count:Int?
    var Block_Count:Int?
    var Win_Count:Int?
    var Loss_Count:Int?
    var draw :Int?
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
        draw                <- map["draw"]
    }
}

struct GameSeasonModal : Mappable {
    var season_id:String?
    var game_id:String?
    var user_id:String?
    var player_id:String?
    var season_name:String?
    var game_name:String?
    var game_date: String?
    var season_date: String?
    var image: String?
    var created_at:String?
    var updated_at:String?
    var game_result: String?
    var is_score_added:String?
    var is_season : String?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        season_id          <- map["season_id"]
        game_id            <- map["game_id"]
        user_id            <- map["user_id"]
        player_id          <- map["player_id"]
        season_name        <- map["season_name"]
        game_name          <- map["game_name"]
        game_date          <- map["game_date"]
        season_date        <- map["season_date"]
        image              <- map["image"]
        created_at         <- map["created_at"]
        updated_at         <- map["updated_at"]
        game_result        <- map["game_result"]
        is_score_added     <- map["is_score_added"]
        is_season          <- map["is_season"]
    }
}
/*"game_id": "6",
"user_id": "5",
"player_id": "1",
"season_id": "1",
"game_name": "Test Shreya-10",
"game_date": "2019-10-17",
"is_season": "1",
"game_result": "4",
"is_score_added": "0",
"created_at": "2020-03-07 05:44:39",
"updated_at": "2020-03-07 05:44:39"
/*"season_id": "4",
"user_id": "5",
"player_id": "1",
"season_name": "Test Seasion-11",
"season_date": "2019-10-17",
"created_at": "2020-03-07 05:44:48",
"updated_at": "2020-03-07 05:44:48"*/*/
