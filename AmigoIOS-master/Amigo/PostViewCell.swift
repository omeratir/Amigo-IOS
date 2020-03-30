//
//  PostViewCell.swift
//  Amigo
//
//  Created by אביעד on 08/03/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import Firebase

class PostViewCell: UITableViewCell {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var deletePost: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ImageView.layer.borderWidth = 1
                      ImageView.layer.masksToBounds = false
                      ImageView.layer.borderColor = UIColor.black.cgColor
                      ImageView.layer.cornerRadius = ImageView.frame.height/2
                      ImageView.clipsToBounds = true
        
        // Initialization code
    }
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Configure the view for the selected state
      }

    func deletePost(postId: String){
         print("get in to here")
         Model.instance.deleteAPosts(postIds: postId)
      //   Model.instance.deletePost(postId: postId)
        
     }
    
//      var post:Post?
//    @IBAction func deleteButtom(_ sender: Any) {
//        var db : Firestore!
//        db = Firestore.firestore()
//        var city:String?
//        db.collection("posts").getDocuments { (snapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in snapshot!.documents {
//                    city = document.get("postId") as! String
//                    print(city)
//                    print("shiooo")
//                    if(self.post?.postId == city){
//                        break;
//                    }
//                }
//            }
//
//        }
//        if(post?.postId == city) {
//            print("hellooo")
//            deletePost(postId: post!.postId)
//        }
//    }
    
}
