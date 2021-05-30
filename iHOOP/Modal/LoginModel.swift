//
//  File.swift
//  Speed Shopper
//
//  Created by mac on 13/04/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import ObjectMapper

/*"data": {
 "id": "42",
 "firstname": "pie",
 "lastname": "p",
 "dob": "2018-12-19",
 "experience": "5",
 "mobile_no": "9977220261",
 "id_proofimage": "658c8f1dc39d4b36466a2ec092ded99c.png",
 "id_status": "0",
 "profile_pic": "9edf1d64b0725836d73ebc3cbcc43c57.png",
 "path": "http://192.168.1.139/ConnectCare/public/images/profile/",
 "doc_path": "http://192.168.1.139/ConnectCare/public/document/",
 
 */

struct usermodal : Mappable {
    
    var name: String!
    var dob: String!
    var email: String!
    var longitude: String!
    var contact: String!
    var latitude: String!
    var device_type: String!
    var device_token: String!
    var gender: String!
    var image: String!
    var parent_id:String!
    var id:  String!
    
    init?(map: Map) {
        
    }
    init() {}
    mutating func mapping(map: Map) {
        name                         <- map["name"]
        parent_id                  <- map["parent_id"]
        id                  <- map["id"]
        email           <- map["email"]
        gender              <- map["gender"]
        image               <- map["image"]
        contact         <- map["contact"]
        latitude         <- map["latitude"]
        longitude         <- map["longitude"]
        
    }
}
/*
 age = 25;
 contact = "";
 "created_date" = "2019-05-03 17:47:40";
 "device_id" = 323sd2f2ds3f;
 "device_token" = device555555555555;
 "device_type" = iOS;
 email = "armankhan@infograins.com";
 gender = Male;
 id = 1;
 image = "http://192.168.1.133/startrak/upload/child-profile/default.jpg";
 latitude = "";
 longitude = "";
 name = "Arman khan";
 "parent_id" = 2;
 "updated_date" = "2019-05-03 17:47:40";
 "verify_status" = 2;
 */
struct profileinfoModal : Mappable {
    
    var name: String!
    var dob: String!
    var email: String!
    var longitude: String!
    var contact: String!
    var latitude: String!
    var device_type: String!
    var device_token: String!
    var gender: String!
    var image: String!
    var parent_id:String!
    var id:  String!
    
    init?(map: Map) {
        
    }
    init() {}
    mutating func mapping(map: Map) {
        name                         <- map["name"]
        parent_id                  <- map["parent_id"]
        id                  <- map["id"]
        email           <- map["email"]
        gender              <- map["gender"]
        image               <- map["image"]
        contact         <- map["contact"]
        latitude         <- map["latitude"]
        longitude         <- map["longitude"]
        
    }
}
struct UploadDocListModel : Mappable {
    
    var userid: String!
    var document: String!
    var type: String!
    var status: String!
    var created_at: String!
    var path: String?
    var id: String!
    
    init?(map: Map) {
        
    }
    
    init() {}
    mutating func mapping(map: Map) {
        userid               <-  map["userid"]
        document             <-  map["document"]
        type                 <-  map["type"]
        status               <-  map["status"]
        created_at           <-  map["created_at"]
        id                   <- map ["id"]
        path                 <- map["path"]
    }
}
