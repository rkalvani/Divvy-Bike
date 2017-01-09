//
//  DetailViewController.swift
//  Divvy Bike
//
//  Created by rkalvani on 10/10/16.
//  Copyright © 2016 rkalvani. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    
    var detailItem : [String: String]!
   
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //sets the coordinate of selected station and centers it 
        let coordinate = CLLocationCoordinate2DMake(Double(detailItem["latitude"]!)!, Double(detailItem["longitude"]!)!)
        setCenterOfMapToLocation(coordinate)
        
        
    }
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // sets the window zoom
        let region = MKCoordinateRegion(center: location, span: span)
        let pin = MKPointAnnotation()
        pin.coordinate = location // drops a pin on the location as an additional feature
        pin.title = detailItem["title"]
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }
    
}
