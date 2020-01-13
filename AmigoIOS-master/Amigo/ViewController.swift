//
//  ViewController.swift
//  Amigo
//
//  Created by Shiran Klein on 30/12/2019.
//  Copyright © 2019 Shiran Klein. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var lblsSelectedItem:UILabel?
    @IBOutlet weak var pickerView:UIPickerView?
    var countryName = ["Tel-Aviv", "Petah-Tiqwa","Rishon Lezion", "Tveria"]
    let rowHieight:CGFloat = 50.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryName.count
    }
    func pickerView(_ pickerView: UIPickerView,titleForRow row:Int, ForComponent component:Int) -> String?{
        return countryName[row]
    }
    

}

