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
    
    var isHealthy: Bool
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(lat: CLLocationDegrees, long: CLLocationDegrees, _isHealthy: Bool) {
        
        latitude = lat
        longitude = long
        isHealthy = _isHealthy
        
    }
    
}
