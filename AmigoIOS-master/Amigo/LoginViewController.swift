//
//  LoginViewController.swift
//  Amigo
//
//  Created by Guy Peleg on 06/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class LoginViewController: UIViewController,RegiserDelegate {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
       func onComplete(success: Bool) {
          print("on Complete signInOut \(success)")
                    if success == true {
                        print("on Complete signInOut success")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let signInVC = storyboard.instantiateViewController(withIdentifier: "TabController")
                        self.present(signInVC, animated: true, completion: nil)
                    }
        }
    
    
    @IBAction func Connect(_ sender: Any) {
       ProgressHUD.show("Waiting...",interaction: false)
                 
                 // properties
                 guard
                     let email = email.text,
                     let password = password.text
                         else {
                             ProgressHUD.showError("fill all fields")
                             return}
              AuthUsers.signIn(email: email, password: password, onSuccess: {
                     print("Successfully signed user in" )
                     ProgressHUD.showSuccess("Success")
                     self.onComplete(success: true)
                     //self.dismiss(animated: true, completion: nil )
                 }) { (errorMsg) in
                     print(errorMsg!)
                     ProgressHUD.showError(errorMsg!)
                     return
                 }

//        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user,error) in
//                   if user != nil {
//                   print("aviad")
//                   }
//                   if error != nil {
//                       print(":(")
//                   }
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        let layer = CAGradientLayer()
        let color1 = UIColor(red:0.99, green: 0.48, blue: 0.48, alpha: 1.0)
        let color2 = UIColor(red:0.65, green: 0.76, blue: 1.00, alpha: 1.0)

        layer.colors = [ color1.cgColor ,color2.cgColor]
        layer.frame = view.frame
        view.layer.insertSublayer(layer, at: 0)

        
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
