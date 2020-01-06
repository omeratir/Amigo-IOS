//
//  MapViewController.swift
//  Amigo
//
//  Created by אביעד on 05/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate {

    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate=self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        
     
        let camera = GMSCameraPosition.camera(withLatitude: 31.961020, longitude: 34.801620, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled=true
        mapView.settings.myLocationButton=true
        mapView.padding=UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        self.view = mapView
  
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
