//
//  ViewController.swift
//  iOSDev2015
//
//  Created by Daniel Richards on 7/11/15.
//  Copyright (c) 2015 Daniel Richards. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SenseSdk



class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
 
    @IBOutlet weak var history: UIImageView!
    @IBOutlet weak var map: UIImageView!
    @IBOutlet weak var credits: UIImageView!
    @IBOutlet weak var hand: UIImageView!
    var manager = CLLocationManager()
  
    
    @IBAction func test(sender: AnyObject) {
        
        
        println("TestButton pressed")
        
        
//        
//        let place = PoiPlace(latitude: "\(latitude)", longitude: -121.918564, radius: 50, name: "McDonalds", id: "mcdonalds", types: [.Restaurant])
//        
//        let error = SenseSdkErrorPointer.create()
//        
//        SenseSdkTestUtility.fireTrigger(
//            fromRecipe: "ArrivedAtRestaurant", //"restaurantRecipe",
//            confidenceLevel: ConfidenceLevel.High,
//            places: [place],
//            errorPtr: error)

    
        
        startGps()
        
    }
    
    func startGps()
    {
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        
        print("loc did update")
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        
        var latDelt:CLLocationDegrees = 0.1
        
        var lonDelt:CLLocationDegrees = 0.1
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelt, lonDelt)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        
                println(latitude)
                println(longitude)
        

        
    }


//    http://www.sense360.com/docs.html#testing-while-at-your-desk
 
    
    func handleNotification(notification: UILocalNotification) {

        println("Handling Notification")
        
        if let opts = notification.userInfo {
            NSLog("%@", opts)
        }
     
    }
    
    @IBOutlet weak var map1: UIButton!
    override func viewDidLayoutSubviews() {
        
//        history.image = UIImage(named: "history.png")
//        history.center = CGPointMake(200, -75)
//        
//        map.image = UIImage(named: "mapimage.png")
//        map.center = CGPointMake(200, -75)
//    
//        credits.image = UIImage(named: "Untitled-6.png")
//        credits.center = CGPointMake(200, -75)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
//        UIView.animateWithDuration(0.5, delay: 1.0, options: .Autoreverse, animations: {
//            self.hand.transform = CGAffineTransformMakeRotation((4.0 * CGFloat(M_PI)) / 180.0)
//        }, completion: nil)
//        
//      
//        UIView.animateWithDuration(1.2,animations: {
//            self.history.center = CGPointMake(200, 570)
//        })
//        
//       UIView.animateWithDuration(1.4,animations: {
//            self.map.center = CGPointMake(200, 465)
//        })
//        
//        UIView.animateWithDuration(1, animations: {
//            self.credits.center = CGPointMake(200, 675)
       // })
        
    }
    
    
    }



