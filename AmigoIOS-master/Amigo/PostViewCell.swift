//
//  PostViewCell.swift
//  Amigo
//
//  Created by אביעד on 08/03/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit

class PostViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var PlaceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Configure the view for the selected state
      }


}
