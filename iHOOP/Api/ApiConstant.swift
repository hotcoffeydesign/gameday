//
//  ApiConstant.swift
//  Speed Shopper
//
//  Created by mac on 13/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

struct ApiConstant {
    
    static let kDeviceType = "iOS"
    struct ApiType {
        static let kUser = "user/"
        static let kPurchase = "Purchase/"
        static let kStripePayment = "StripePayment/"
        static let KOffer = "Offers/"
        static let KStoreProduct = "StoreProduct/"
        
    }
    struct ApiAction {
        static let kLogin = "UserController/login"
        static let kSignup = "UserController/UserRegistration"
        static let kLogout = "UserController/logout"
        static let kplayerList = "UserController/playerList"
        static let kaddPlayer = "UserController/addPlayer"
        static let kUpdatePlayer = "UserController/updatePlayer"
        static let kDeletePlayer = "UserController/deletePlayer"
        static let kgamelist = "Sports/game_list"
        static let kseasonlist = "Sports/season_list"
        static let kAddGameResult = "Sports/addGameOfaPlayer"
        static let kseasondelete = "Sports/season_delete"
        static let kgamesdelete = "Sports/game_delete"
        static let kplayerGamePoints = "Sports/scoreBoard"
        static let kAddGame = "Sports/add_game"
        static let kaddseason = "Sports/add_season"
        static let kForgot = "Sports/forget_password"
    }
    
    struct ApiKey {
        static let kFName = "fname"
        static let kLName = "lname"
        static let kUsername = "username"
        static let khashID = "hashID"
        static let kPlayerID = "player_id"
        static let kemail = "email"
        static let kpassword = "password"
        static let ktoken = "token"
        static let kimage = "image"
        static let kgameName = "game_name"
        static let kgameDate = "game_date"
        static let kgame_id = "game_id"
        static let kseason_id = "season_id"
        static let kseasonName = "season_name"
        static let kseasonDate = "season_date"
        
        
    }
    /*
    [{player_id","value":"210"},
     {ft_H","value":"1"},
     {ft_M","value":"1"},
     {fg_H","value":"1"},
     {fg_M","value":"1"},
     {3pt_H","value":"1"},
     {3pt_M","value":"1"},
     {dreb","value":"1"},
     {oreb","value":"1"},
     {to","value":"1"},
     {stl","value":"1"},
     {asst","value":"1"},
     {blk","value":"1"},
     {game_result\n","value":"0"}]
    */
    struct saveGameKeys {
        static let kPlayerID = "player_id"
        static let kOnePtHit = "ft_H"
        static let kOnePtMiss = "ft_M"
        static let kTwoPtHit = "fg_H"
        static let kTwoPtMiss = "fg_M"
        static let kThreePtHit = "3pt_H"
        static let kThreePtMiss = "3pt_M"
        static let kDefReb = "dreb"
        static let kOffReb = "oreb"
        static let kTo = "to"
        static let kSteal = "stl"
        static let kAssist = "asst"
        static let kBlock = "blk"
        static let kWinLoss = "game_result"
    }
    struct UpdateProfileKey {
        static let kcontact = "contact"
        static let kdob = "dob"
        static let kimage = "image"
        
        
    }
    struct UpdateLocation {
        static let klocation = "address"
        static let klatitude = "latitude"
        static let klongitude = "longitude"
        //static let klocation = "location"
        
        
    }
}
