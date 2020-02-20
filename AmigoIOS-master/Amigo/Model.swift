//
//  Model.swift
//  Amigo
//
//  Created by אביעד on 22/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance = Model()
    
     var modelFirebase:ModelFirebase = ModelFirebase()
    
    private init(){
    }
    
    func add(user:User){
        modelFirebase.add(user:user);
    }
    
    
//    func getAllUsers(callback:@escaping ([User]?)->Void){
//        
//        //get the local last update date
//        let lud = User.getLastUpdateDate();
//        
//        //get the cloud updates since the local update date
//       modelFirebase.getAllUsers(since:lud) { (data) in
//            //insert update to the local db
//            var lud:Int64 = 0;
//            for user in data!{
//                user.addToDb()
//                if user.lastUpdate! > lud {lud = user.lastUpdate!}
//            }
//            //update the students local last update date
//            User.setLastUpdate(lastUpdated: lud)
//            // get the complete student list
//            let finalData = User.getAllUsersFromDb()
//            callback(finalData);
//        }
//    }
    
    func saveImage(image:UIImage, callback:@escaping (String)->Void) {
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
    
    
    ////////////////// USER Authentication ///////////////
    var logedIn = false
    
    func isLoggedIn()->Bool{
        
        return logedIn
    }
    
    func logIn(email:String, pwd:String, callback:(Bool)->Void){
        logedIn = true;
        callback(true);
    }
    
    func logOut(){
        logedIn = false;
    }
    
    func register(fullname:String, email:String, pwd:String,url:String, callback:(Bool)->Void){
        logedIn = true;
        callback(true);
        
    }

}
class ModelEvents{
    static let UserDataEvent = EventNotificationBase(eventName: "com.Amigo.UserDataEvent");
    static let LoggingStateChangeEvent = EventNotificationBase(eventName: "com.Amigo.LoggingStateChangeEvent");
    
    static let CommentsDataEvent = StringEventNotificationBase<String>(eventName: "com.Amigo.CommentsDataEvent");
    private init(){}
}

class EventNotificationBase{
    let eventName:String;
    
    init(eventName:String){
        self.eventName = eventName;
    }
    
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                callback();
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: nil);
    }
}

class StringEventNotificationBase<T>{
    let eventName:String;
    
    init(eventName:String){
        self.eventName = eventName;
    }
    
    func observe(callback:@escaping (T)->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                let strData = data.userInfo!["data"] as! T
                                                callback(strData);
        }
    }
    
    func post(data:T){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: ["data":data]);
    }
}
