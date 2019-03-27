//
//  ViewController.swift
//  IOSLocationAware
//
//  Created by Ricardo Hui on 27/3/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let location = locations[0]
        self.latitudeLabel.text = String(location.coordinate.latitude)
        self.longtitudeLabel.text = String(location.coordinate.longitude)
        self.courseLabel.text = String(location.course)
        self.speedLabel.text = String(location.speed)
        self.altitudeLabel.text = String(location.altitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil{
                print(error)
            }else{
                if let placemark = placemarks?[0]{
                    var address = ""
                    if placemark.subThoroughfare != nil{
                        address += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil{
                        address += placemark.thoroughfare! + " "
                    }
                    if placemark.subLocality != nil{
                        address += placemark.subLocality! + " "
                    }
                    if placemark.subAdministrativeArea != nil{
                        address += placemark.subAdministrativeArea! + " "
                    }
                    if placemark.country != nil{
                        address += placemark.country! + " "
                    }
                    self.addressLabel.text = address
                }
            }
        }
    }

}

