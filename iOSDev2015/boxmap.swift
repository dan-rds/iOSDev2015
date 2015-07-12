//
//  boxmap.swift
//  iOSDev2015
//
//  Created by Daniel Richards on 7/11/15.
//  Copyright (c) 2015 Daniel Richards. All rights reserved.
//

import UIKit
import UIKit
import MapboxGL

class boxmap: UIViewController {

    override func viewDidLoad() {
        
        
        
        
        class ViewController: UIViewController, MGLMapViewDelegate {
            override func viewDidLoad() {
                super.viewDidLoad()
                
                let mapView = MGLMapView(frame: view.bounds)
                mapView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                
                // set the map's center coordinate
                mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 40.7326808,
                    longitude: -73.9843407),
                    zoomLevel: 12, animated: false)
                view.addSubview(mapView)
            }
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
