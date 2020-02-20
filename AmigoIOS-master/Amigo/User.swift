//
//  User.swift
//  Amigo
//
//  Created by אביעד on 18/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import Foundation
import Firebase

class User {
    let id:String
    var fullname:String = ""
    var ImagAvatr:String = ""
    var email:String = ""
    var lastUpdate: Int64?
    
    init(id:String){
        self.id = id
    }

//        init(withSnapshot: DataSnapshot) {
//         let dict = withSnapshot.value as! [String:AnyObject]
//
//        id = withSnapshot.key
//        fullname = dict["fullname"] as! String
//
//    }
}
