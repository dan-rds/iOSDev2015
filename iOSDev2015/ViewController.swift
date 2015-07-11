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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func testButtonPressed(sender: AnyObject) {
        
        NSLog("TestButton pressed")
        
        let place = PoiPlace(latitude: 34, longitude: 34, radius: 50, name: "McDonalds", id: "McDonalds", type: .Restaurant)
        let error = SenseSdkErrorPointer.create()
        SenseSdkTestUtility.fireTrigger(fromRecipe: "restaurantRecipe", confidenceLevel: ConfidenceLevel.High, places: [place], errorPtr: error)
        
    }
    
    

}

