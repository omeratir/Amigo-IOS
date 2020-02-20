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
             
        //-------user's photo-------//
          let id = Auth.auth().currentUser!.uid
         let storage = Storage.storage()
        let str = storage.reference().child(id).downloadURL(completion: { (url, error) in
            if error == nil {
                print("aviad")
                print(url)
                self.ImageProfile.kf.setImage(with: url)
            }
        })
        
        
        //-------user's fullname-------//
        var db : Firestore!
             db = Firestore.firestore()
            let uid = Auth.auth().currentUser?.uid
        var name:String?
        db.collection("users").getDocuments { (snapshot, err) in
                       if let err = err {
                           print("Error getting documents: \(err)")
                       } else {
                        for document in snapshot!.documents {
                            let docId = document.documentID
                            print("docid")
                            print(docId)
                            if(uid == docId){
                            name = document.get("fullname") as! String
                              print("guy")
                            print(name)
                            self.Name.text = name
                            print("omer")
                            print(name)
                            }
                         }
                
                       }
                }
         
     }
 
}
//    func readArray(){
//        var db : Firestore!
//        db = Firestore.firestore()
//         let uid = Auth.auth().currentUser?.uid
//        db.collection("users").getDocuments { (snapshot, err) in
//                  if let err = err {
//                      print("Error getting documents: \(err)")
//                  } else {
//                      for document in snapshot!.documents {
//                         let docId = document.documentID
//                         let name = document.get("fullname") as! String
//                         print("shiran")
//                        print(name)
//                        self.Name.text = name
//                      }
//                  }
//           }
//
//}
        



