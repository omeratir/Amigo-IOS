//
//  User.swift
//  Amigo
//
//  Created by אביעד on 18/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import Foundation

class User {
    var email : String?
    var profileImageUrl : String?
    var name : String?
    var id : String?
    var password : String?
    var lastUpdate : Double?
    
}
extension User{
    
    static func transformUserFromJson(json : [String : Any] , key : String) -> User{
        let user : User = User()
        user.email = json["email"] as? String
        user.profileImageUrl = json["profileImageUrl"] as? String
        user.name = json["username"] as? String
        user.id = key
        user.password = json["password"] as? String
        user.lastUpdate = json["lastUpdate"] as? Double
        return user
    }
    
    
    static func transformUserToJson(user : User) -> [String : Any]{
        var json = [String: Any]()
        json["email"]               = user.email
        json["profileImageUrl"]     = user.profileImageUrl
        json["name"]            = user.name
        json["password"]            = user.name
        json["lastUpdate"]          = user.lastUpdate
        return json
    }
    
}
