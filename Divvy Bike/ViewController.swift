//
//  ViewController.swift
//  Divvy Bike
//
//  Created by rkalvani on 10/7/16.
//  Copyright © 2016 rkalvani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!

    var stations = [[String: String]]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let URLString = "http://www.divvybikes.com/stations/json/"
        //if statement check to see if URL is valid
        if let url = NSURL(string: URLString)
        {
            //returns data from object URL. Try checks for URL connections
            if let myData = try? NSData(contentsOfURL: url, options: []) {
                //if data object was created successfully, we create  swift json structure
                let json = JSON(data: myData)
                    print ("wOrkin!")
                 parse(json)
                
            }
            }

}
    //reads the results array from api
    func parse(json: JSON) {
        for result in json["stationBeanList"].arrayValue {
            //grabbing values from keys
            let station = result["stationName"].stringValue
            let dock = result["availableDocks"].stringValue
            let bike = result["availableBikes"].stringValue
            let latitude = result["latitude"].stringValue
            let longitude = result["longitude"].stringValue
            
            //creates a dictionary with keys and values
            let object = ["station" : station, "dock": dock, "bike": bike, "latitude" : latitude, "longitude" : longitude]
            // places it in array
           stations.append(object)
        }
        myTableView.reloadData()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { //sets the title and description in the cells
        let cell = myTableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        let station = stations[indexPath.row]
        cell.textLabel?.text = station["station"]
        cell.detailTextLabel?.text = " Available Bikes: \(station["bike"]!)  Available Docks: \(station["dock"]!)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //passes info through to next view controller in segue
        if let indexPath = myTableView.indexPathForSelectedRow {
            let station = stations[indexPath.row]
            let nextController = segue.destinationViewController as! DetailViewController
            nextController.detailItem = station
        }
        else {
            let nextController = segue.destinationViewController as! LocationViewController
            nextController.station = stations.self
        }
        
    }

    
}

