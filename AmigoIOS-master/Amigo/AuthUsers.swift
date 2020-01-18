//
//  AuthUsers.swift
//  Amigo
//
//  Created by אביעד on 18/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
class AuthUsers {
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
        
    }
    
    static func signUp(username: String, email: String, password: String,gender: String,imageData: Data, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult :AuthDataResult?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = authDataResult?.user.uid
            let storageRef = Storage.storage().reference().child("profile_image").child(uid!)

            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                storageRef.downloadURL(completion: { (url :URL?, error :Error?) in
                    if error != nil {
                        onError(error!.localizedDescription)
                        return
                    }
                    self.setUserInfomation(profileImageUrl: url!.absoluteString, username: username, email: email, gender: gender, uid: uid!, onSuccess: onSuccess)
                })
            })
        }
    }
    static func setUserInfomation(profileImageUrl: String, username: String, email: String,gender:String, uid: String, onSuccess: @escaping () -> Void) {
        let usersReference = Api.User.REF_USERS
        let newUserReference = usersReference.child(uid)
        let user: User = User()
        user.name = username
        user.email = email
        user.gender = gender
        user.profileImageUrl = profileImageUrl
        user.lastUpdate = Double(Date().timeIntervalSince1970)
        newUserReference.setValue(User.transformUserToJson(user: user))
        onSuccess()
    }
}
