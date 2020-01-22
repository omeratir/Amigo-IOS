//
//  MyProfileViewController.swift
//  Amigo
//
//  Created by Guy Peleg on 06/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
class MyProfileViewController: UIViewController {

    @IBOutlet weak var ImageProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let store = Storage.storage()
   let storage = Storage.storage()
        let storageRef = storage.reference()
        let gsReference = storage.reference(forURL: "gs://amigo-e1b90.appspot.com/email")
        let user = Auth.auth().currentUser
        let islandRef = storageRef.child("\(user?.email)")
        
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            self.ImageProfile.image = UIImage(data: data!)
          }
        }
           
        // Create a reference from a Google Cloud Storage URI
//        let gsReference = store.reference(forURL: "gs://amigo-e1b90.appspot.com/email")
//
//       let user = Auth.auth().currentUser
//      //  let userProfilesRef = storeRef.child("email")
//       //  let pathReference = store.reference(withPath: "email")
//       // let islandRef = gsReference.child("\(user?.email)")
//        print ("\(user?.email)")
//        //userProfilesRef.child("\(email).png")
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
//          if let error = error {
//            print ("Uh-oh")
//            // Uh-oh, an error occurred!
//          } else {
//            // Data for "images/island.jpg" is returned
//            self.ImageProfile.image = UIImage(data: data!)
//            print("yay")
//
//          }
//        }
            
    }


    //url!.absoluteString
 

}
