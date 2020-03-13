//
//  AddPostViewController.swift
//  Amigo
//
//  Created by אביעד on 17/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD

class AddPostViewController: UIViewController {
    
    var name : String?
    var city : String?
    
    @IBOutlet weak var recTitle: UINavigationItem!
    
    @IBOutlet weak var placeText: UITextField!
    
    @IBOutlet weak var textOfRecommend: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage : UIImage?
    
    //upload photo from libary/camara
    @IBAction func uploadPhoto(_ sender: Any) {
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
    
    //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    //       {
    //           let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    //
    //           imageView.image = image
    //           picker.dismiss(animated: true, completion: nil)
    //       }
    //
    //       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    //           picker.dismiss(animated: true, completion: nil)
    //       }
    //
    
    
    //press on the post button and save the post to db
    @IBAction func PostBtn(_ sender: Any) {
        print("post Button press")
        view.endEditing(true)
        ProgressHUD.show("waiting...",interaction: false)
        var db : Firestore!
        db = Firestore.firestore()
        let idPost = db.collection("posts").document().documentID
        Model.instance.saveImagePost(image: self.imageView.image!){ (url) in
            if url != "" {
                Model.instance.savePost(title: self.city!, placeLocation: self.placeText.text!, userName:self.name! , recText: self.textOfRecommend.text!, url: "url") { (success) in
                    if success {
                        let po = Post(id: idPost);
                        po.title = self.city!
                        po.userName = self.name!
                        po.placeImage = url
                        po.recText = self.textOfRecommend.text!
                        po.placeLocation = self.placeText.text!
                        Model.instance.addPost(post: po)
                        let main = UIStoryboard(name:"Main", bundle: nil)
                        let home = main.instantiateViewController(identifier: "Home")
                        self.present(home, animated: true, completion: nil)
                    }
                }
                
                
                
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var db : Firestore!
        db = Firestore.firestore()
        
        //change the title of the page to the pin's title that pressed
        db.collection("cities").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    self.city = document.get("title") as! String
                    self.recTitle.title = self.city!
                    
                }
            }
        }
        
        
        //get the name of the user that write the post
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    if(uid == docId){
                        self.name = document.get("fullname") as! String
                        
                    }
                }
                
            }
        }
    
                
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
                tapGesture.numberOfTapsRequired = 1
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tapGesture)
            }
            
            @objc func handleSelectPhoto(){
                print("handle Select Photo")
                let picker = UIImagePickerController()
                picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate //current vc
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                present(picker, animated: true, completion: nil)
            }
        }
        
        extension AddPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                print("did finish picking media")
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    selectedImage = image
                    imageView.image = image
                }
                dismiss(animated: true, completion: nil)
            }
}


