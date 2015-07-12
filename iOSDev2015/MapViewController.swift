//
//  MapViewController.swift
//  iOSDev2015
//
//  Created by Daniel Richards on 7/11/15.
//  Copyright (c) 2015 Daniel Richards. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView : MKMapView!
    
    var manager:CLLocationManager!
    
         override func viewDidLoad() {
                super.viewDidLoad()
                
                manager = CLLocationManager()
                manager.delegate = self
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
                
                var latitude:CLLocationDegrees = 48.3
                var longditude:CLLocationDegrees = 9.99
                
                var latDelta:CLLocationDegrees = 0.01
                var longDelta:CLLocationDegrees = 0.01
                
                var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
                
                var churchLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longditude)
                
                
                
                var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(churchLocation, theSpan)
                
                mapView.setRegion(theRegion, animated: true)
                
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = churchLocation
                
                annotation.title = "test"
                
                annotation.subtitle = "another test"
                
                mapView.addAnnotation(annotation)
                
                var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
                
                lpgr.minimumPressDuration = 2.0;
                
                mapView.addGestureRecognizer(lpgr)
                
                
                
            }
            
            func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
                
                var userLocation:CLLocation = locations[0] as! CLLocation
                
                var latitude:CLLocationDegrees = userLocation.coordinate.latitude
                
                var longitude:CLLocationDegrees = userLocation.coordinate.longitude
                
                var latDelta:CLLocationDegrees = 0.1
                
                var lonDelta:CLLocationDegrees = 0.1
                
                var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                
                var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                
                var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                
                mapView.setRegion(region, animated: true)
                
    

                println("locations = \(locations)")
            }
            
            func locationManager(manager:CLLocationManager, didFailWithError error:NSError)
            {
                println(error)
                println("test")
            }
            
            func action(gestureRecognizer:UIGestureRecognizer) {
                var touchPoint:CGPoint = gestureRecognizer.locationInView(self.mapView)
                
                var touchMapCoordinate:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
                
                var newannotation = MKPointAnnotation()
                
                newannotation.coordinate = touchMapCoordinate
                
                newannotation.title = "test"
                
                newannotation.subtitle = "another test"
                
                mapView.addAnnotation(newannotation)
                
                println(touchMapCoordinate.latitude)
                println(touchMapCoordinate.longitude)
                
                var ceo:CLGeocoder = CLGeocoder()
                
                
                
                var arr = []
                
                var err = []
                
                var churchLocationn:CLLocation = CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
                
                CLGeocoder().reverseGeocodeLocation(churchLocationn, completionHandler:
                    {(placemarks, error) in
                        if (error != nil) {println("reverse geodcode fail: \(error.localizedDescription)")}
                        let pm = placemarks
                        let p = CLPlacemark(placemark: pm?[0] as! CLPlacemark)
                        println(p.subThoroughfare)
                        println(p.thoroughfare)
                })

        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
