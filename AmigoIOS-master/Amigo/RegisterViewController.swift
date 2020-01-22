//
//  RegisterViewController.swift
//  Amigo
//
//  Created by Guy Peleg on 06/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import ProgressHUD

protocol RegiserDelegate{
    func onComplete(success:Bool);
}

class RegisterViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //  var delegate:RegiserDelegate?
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    @IBOutlet weak var pickerCity: UIPickerView!
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    
    
    func onComplete(success: Bool) {
        print("on Complete signInOut \(success)")
        if success == true {
            print("on Complete signInOut success")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "TabController")
            self.present(signInVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func finishRegister(_ sender: Any) {
        print("sign up pressed")
        //dismiss keyboard
        self.view.endEditing(true)
        ProgressHUD.show("Waiting...",interaction: false)
        //case fields are empty
        if(emailUser.text?.isEmpty ?? true || passwordUser.text?.isEmpty ?? true){
            
            // alert message "fill all fields"
            ProgressHUD.showError("PLEASE fill all fields")
            return
        }
        
        //values for sign
        guard let email = emailUser.text else {return}
        guard let password = passwordUser.text else {return}
        guard let username = fullName.text else {return}
        //set profile image
        guard let profileImg = self.imageViewAvatar.image else {return}
        //upload data
        guard let uploadData : Data = profileImg.jpegData(compressionQuality: 0.3) else {return}
        let db = Firestore.firestore()
        //db.collection("users").document(<#T##documentPath: String##String#>)
        db.collection("users").addDocument(data: ["fullname": username,"email":email,"password":password])
        
        let store = Storage.storage()
        let storeRef = store.reference()
        let userProfilesRef = storeRef.child("email")
        //let logoRef = storeRef.child("images.png")
        // let userProfiles = logoRef.parent()?.child("profiles")
        guard let ProfileImage = self.imageViewAvatar.image else {return}
        //upload data
        guard let UpTheData : Data = profileImg.jpegData(compressionQuality: 0.3) else {return}
        let uploadUserProfileTask = userProfilesRef.child("\(email)").putData(UpTheData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("Error occurred: \(error)")
                return
            }
        }
        print ("\(email)")
        AuthUsers.signUp(username: username, email: email, password: password, imageData: uploadData, onSuccess: {
            
            print("Seccessfuly created user and saved information to DB")
            
            ProgressHUD.showSuccess("Success")
            print("Successfully signed user up" )
            //   self.dismiss(animated: true, completion: {() in
            self.onComplete(success: true);
            //    })
            
        }) { (errorMsg) in
            ProgressHUD.showError(errorMsg)
            return
        }
    }
    
    //    @IBAction func loginConnect(_ sender: Any) {
    //        Auth.auth().signIn(withEmail: self.emailUser.text! , password: self.passwordUser.text!) { (user,error) in
    //                   if user != nil {
    //                   print("aviad")
    //                   }
    //                   if error != nil {
    //                       print(":(")
    //                   }
    //        }
    //    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //Upload photo button
    @IBAction func uploadPhotoBtn(_ sender: Any)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            if(UIImagePickerController.isSourceTypeAvailable(.camera))
            {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else
            {
                print("Camera not available")
            }
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageViewAvatar.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    var pickerData: [String] = [String]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        let layer = CAGradientLayer()
        let color1 = UIColor(red:0.99, green: 0.48, blue: 0.48, alpha: 1.0)
        let color2 = UIColor(red:0.65, green: 0.76, blue: 1.00, alpha: 1.0)
        
        layer.colors = [ color1.cgColor ,color2.cgColor]
        layer.frame = view.frame
        view.layer.insertSublayer(layer, at: 0)
        
        //Image Picker
        
        // City Picker
        self.pickerCity.delegate = self
        self.pickerCity.dataSource = self
        pickerData = ["Tel-Aviv", "Petah-Tiqwa","Rishon Lezion", "Tveria"]
    }
    
}
extension RegisterViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
