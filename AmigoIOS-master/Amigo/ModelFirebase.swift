//
//  ModelFirebase.swift
//  Amigo
//
//  Created by אביעד on 22/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    func add(user:User){
        let db = Firestore.firestore()
//        var ref: DocumentReference? = nil
        let json = user.toJson();
        db.collection("users").document(user.id).setData(json){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.UserDataEvent.post();
            }
        }
    }
    
    func addPost(post:Post){
            let db = Firestore.firestore()
    //        var ref: DocumentReference? = nil
            let json = post.toJson();
        db.collection("posts").document(post.title).setData(json){
                err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    ModelEvents.UserDataEvent.post();
                }
            }
        }
    
    //TODO: implement since
    func getAllPostsRishon(since:Int64, callback: @escaping ([Post]?)->Void){
        let db = Firestore.firestore()
        db.collection("posts").order(by: "title").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Post]();
                for document in querySnapshot!.documents {
                    if let ts = document.data()["lastUpdate"] as? Timestamp{
                        let tsDate = ts.dateValue();
                        print("\(tsDate)");
                        let tsDouble = tsDate.timeIntervalSince1970;
                        print("\(tsDouble)");

                    }
                    data.append(Post(json: document.data()));
                }
                callback(data);
            }
        };
    }
        
        
}

