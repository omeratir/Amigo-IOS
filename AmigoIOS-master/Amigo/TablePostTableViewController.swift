//
//  TablePostTableViewController.swift
//  Amigo
//
//  Created by אביעד on 21/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import Firebase
class TablePostTableViewController: UITableViewController {

    @IBOutlet weak var recTitle: UINavigationItem!
    
    var data = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var db : Firestore!
             db = Firestore.firestore()
        
        //change the title of the page to the pin that pressed
             var city:String?
                    db.collection("cities").getDocuments { (snapshot, err) in
                                   if let err = err {
                                       print("Error getting documents: \(err)")
                                   } else {
                                    for document in snapshot!.documents {
                                        city = document.get("title") as! String
                                     self.recTitle.title = city
                                     print("shi")
                                     print(city)
                                     }
                    }
             
             }
       
        
        var data = [Post]()
          
              
              self.refreshControl = UIRefreshControl()
              self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
              
              ModelEvents.PostDataEvent.observe {
                  self.refreshControl?.beginRefreshing()
                  self.reloadData();
              }
              self.refreshControl?.beginRefreshing()
              reloadData();
          }
          
          @objc func reloadData(){
            Model.instance.getAllPostsRishon{ (_data:[Post]?) in
                  if (_data != nil) {
                      self.data = _data!;
                      self.tableView.reloadData();
                  }
                  self.refreshControl?.endRefreshing()
              };
          }
          
          override func viewWillAppear(_ animated: Bool) {
              print("viewWillAppear")
              
          }
          
          
          // MARK: - Table view data source
          
          override func numberOfSections(in tableView: UITableView) -> Int {
              return 1
          }
          
          override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return data.count
          }
          
          
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell:PostViewCell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as! PostViewCell
              
              let st = data[indexPath.row]
            cell.Name.text = st.userName
            cell.PlaceLabel.text = st.title
            cell.ImageView.image = UIImage(named: "place")
            if st.placeImage != ""{
                cell.ImageView.kf.setImage(with: URL(string: st.placeImage));
              }
              return cell
          }
          
            // MARK: - Navigation
            
            // In a storyboard-based application, you will often want to do a little preparation before navigation
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if (segue.identifier == "PostInfoSegue"){
                    let vc:PostInfoViewController = segue.destination as! PostInfoViewController
                    vc.post = selected
                }
            }
            
            
            var selected:Post?
            override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                selected = data[indexPath.row]
                performSegue(withIdentifier: "PostInfoSegue", sender: self)
            }
            
            
            @IBAction func backFromCancelLogin(segue:UIStoryboardSegue){
                
            }
        }


  
