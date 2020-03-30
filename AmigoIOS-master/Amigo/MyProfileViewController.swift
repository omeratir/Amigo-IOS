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


class MyProfileViewController: UIViewController, LoginViewControllerDelegate {
    func onLoginSuccess() {
        
    }
    
    func onLoginCancell() {
         self.tabBarController?.selectedIndex = 0;
    }
    @IBOutlet weak var Login: UIButton!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var Logout: UIButton!
    @IBOutlet weak var ImageProfile: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    override func viewWillAppear(_: Bool) {
            super.viewWillAppear(true)
   
        self.profile()
    }
    
      override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.isHidden = true
        self.profile()
       ImageProfile.layer.borderWidth = 1
         ImageProfile.layer.masksToBounds = false
         ImageProfile.layer.borderColor = UIColor.black.cgColor
         ImageProfile.layer.cornerRadius = ImageProfile.frame.height/2
         ImageProfile.clipsToBounds = true
     // var refreshControl = UIRefreshControl()
        view.backgroundColor = UIColor.black
              let layer = CAGradientLayer()
              let color1 = UIColor(red:0.99, green: 0.48, blue: 0.48, alpha: 1.0)
              let color2 = UIColor(red:0.65, green: 0.76, blue: 1.00, alpha: 1.0)

              layer.colors = [ color1.cgColor ,color2.cgColor]
              layer.frame = view.frame
              view.layer.insertSublayer(layer, at: 0)

    
}

    func profile() {
         self.activity.isHidden = false
                if (!Model.instance.isLoggedIn()){
                     self.Logout.isHidden = true
                    self.Login.isHidden = false
        //            let loginVc = LoginViewController.factory()
        //            loginVc.delegate = self
        //            show(loginVc, sender: self)
                    self.activity.isHidden = true
                }
                //-------user's photo-------//
                if(Model.instance.logedIn == true){
                    self.Logout.isHidden = false
                    self.Login.isHidden = true
                   
                  let id = Auth.auth().currentUser!.uid
                    UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
                                                UserDefaults.standard.synchronize()
                 let storage = Storage.storage()
                let str = storage.reference().child(id).downloadURL(completion: { (url, error) in
                    if error == nil {
 
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
                                    if(uid == docId){
                                    name = document.get("fullname") as! String
                                    self.Name.text = name
                                        
                                    }
                                 }

                               }
                        }
                   
             }
         self.activity.isHidden = true
    }
    
    
    @IBAction func LoginButtom(_ sender: Any) {
        let loginVc = LoginViewController.factory();
                                       loginVc.delegate = self
                                       show(loginVc, sender: self)
    }
    
    
    @IBAction func LogoutButtom(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Are you sure you'd like to logout?", preferredStyle: .alert)

              // yes action
              let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
        Model.instance.logedIn = false
        //self.Name.text = "Login to get name"
       // self.ImageProfile.image = UIImage(named: "avater")
        let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
       } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
       }
//        let loginVc = LoginViewController.factory();
//                              loginVc.delegate = self
//                              show(loginVc, sender: self)
        UserDefaults.standard.removeObject(forKey: "user_uid_key")
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "Home")
            self.present(signInVC, animated: true, completion: nil)
        }
        alert.addAction(yesAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                present(alert, animated: true, completion: nil)
        
    }
}
