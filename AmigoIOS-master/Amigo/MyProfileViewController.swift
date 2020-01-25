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
import Kingfisher
class MyProfileViewController: UIViewController {

    @IBOutlet weak var ImageProfile: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                  
          let id = Auth.auth().currentUser!.uid
//        let db = Database.database().reference().child("users").child(id).
//        print("shiran")
//        print(db)
         let storage = Storage.storage()
        let avi = storage.reference().child(id).downloadURL(completion: { (url, error) in
            if error == nil {
                print("aviad")
                print(url)
                self.ImageProfile.kf.setImage(with: url)
            }
        })
}
}


        

