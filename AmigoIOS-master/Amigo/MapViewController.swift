//
//  MapViewController.swift
//  Amigo
//
//  Created by אביעד on 05/01/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
  // 1
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // 2
    guard let annotation = annotation as? Artwork else { return nil }
    // 3
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .system)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    return view
  }
    @objc func buttonAction(sender: AnyObject)
    {
        self.performSegue(withIdentifier: "MoveNext", sender: nil)
    }
}



class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //where we start
        let initialLocation = CLLocation(latitude: 31.961020, longitude: 34.801620)
        centerMapOnLocation(location: initialLocation)
    }
    //requst to see your location
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
      if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        mapView.showsUserLocation = true
      } else {
        locationManager.requestWhenInUseAuthorization()
      }
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      checkLocationAuthorizationStatus()
    }
    //distans of the screen -zoom
    let regionRadius: CLLocationDistance = 250000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
        
        // show artwork on map - where marker in the map
        let artwork = Artwork(title: "Rishon-Lezion",
          locationName: "aviad",
          discipline: "rishon",
          coordinate: CLLocationCoordinate2D(latitude: 31.961020, longitude: 34.801620))
        let artwork2 = Artwork(title: "Haifa",
                 locationName: "aviad",
                 discipline: "haifa",
                 coordinate: CLLocationCoordinate2D(latitude: 32.794044, longitude: 34.989571))
        mapView.addAnnotation(artwork)
         mapView.addAnnotation(artwork2)
        mapView.delegate = self
        
        
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

