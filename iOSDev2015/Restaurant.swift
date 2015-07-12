//
//  Restaurant.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import CoreLocation
import MapKit

class Restaurant: Printable {
    
    var name: String = ""
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var isHealthy: Bool = false
    
    var description: String {
        return "Restaurant(name: \(name), lat: \(latitude), long \(longitude), isHealthy: \(isHealthy))"
    }
    
    var annotation: MKPointAnnotation {
        let ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        ann.title = name
        ann.title = "EAT HERE!!"
        return ann
    }
    
    init(name: String, lat: CLLocationDegrees, long: CLLocationDegrees, isHealthy: Bool) {
        
        self.name = name
        latitude = lat
        longitude = long
        self.isHealthy = isHealthy
        
    }
    
}
