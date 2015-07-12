//
//  Restaurant.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import CoreLocation

class Restaurant: NSObject {
    
    var name: String = ""
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var isHealthy: Bool = false
    
    init(name: String, lat: CLLocationDegrees, long: CLLocationDegrees, isHealthy: Bool) {
        
        super.init()
        self.name = name
        latitude = lat
        longitude = long
        self.isHealthy = isHealthy
        
    }
    
}
