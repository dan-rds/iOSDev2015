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
    
    @IBAction func testButtonPressed(sender: AnyObject) {
        
        println("TestButton pressed")
        
        let place = PoiPlace(latitude: 37.375174, longitude: -121.918564, radius: 50, name: "McDonalds", id: "mcdonalds", type: .Restaurant)
        let error = SenseSdkErrorPointer.create()
        SenseSdkTestUtility.fireTrigger(fromRecipe: "restaurantRecipe", confidenceLevel: ConfidenceLevel.High, places: [place], errorPtr: error)
        
    }
    
    func handleNotification(notification: UILocalNotification) {

        println("Handling Notification")
        
        if let opts = notification.userInfo {
            NSLog("%@", opts)
        }
     
    }
    
    override func viewDidLayoutSubviews() {
        
        history.image = UIImage(named: "history.png")
        history.center = CGPointMake(200, -75)
        
        map.image = UIImage(named: "mapimage.png")
        map.center = CGPointMake(200, -75)
    
        credits.image = UIImage(named: "Untitled-6.png")
        credits.center = CGPointMake(200, -75)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: .Autoreverse, animations: {
            self.hand.transform = CGAffineTransformMakeRotation((4.0 * CGFloat(M_PI)) / 180.0)
        }, completion: nil)
        
      
        UIView.animateWithDuration(1.2,animations: {
            self.history.center = CGPointMake(200, 570)
        })
        
       UIView.animateWithDuration(1.4,animations: {
            self.map.center = CGPointMake(200, 465)
        })
        
        UIView.animateWithDuration(1, animations: {
            self.credits.center = CGPointMake(200, 675)
        })
        
    }
}

