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

    @IBOutlet weak var textOfRecommend: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage : UIImage?
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
    
    @IBAction func PostBtm(_ sender: Any) {
            print("post Button press")
                view.endEditing(true)
                ProgressHUD.show("waiting...",interaction: false)
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
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


