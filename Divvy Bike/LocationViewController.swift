//
//  LocationViewController.swift
//  Divvy Bike
//
//  Created by rkalvani on 10/14/16.
//  Copyright © 2016 rkalvani. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var station = [[String: String]]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() { //finds the user's location and opens up with it in the center
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.userLocation.title = "My Location"
        setCenterOfMapToLocation(mapView.userLocation.coordinate)
        
        //VVV tried to get a pin to drop at the locaation of all of the stations
       // for item in station {
       //     let staton = station[item.indexForKey("latitude")]
      //      let coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
      //      let pin = MKPointAnnotation()
     //       pin.coordinate = coordinate
     //       pin.title = station["title"]
      //  }
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locationManager.location)
    }
    
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) //sets zoom view size
        let region = MKCoordinateRegion(center: location, span: span)
        let pin = MKPointAnnotation() // drops a pin as an additional feature
        pin.coordinate = location
        pin.title = "My Location"
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }
    
}
