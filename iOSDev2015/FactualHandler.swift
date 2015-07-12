//
//  FactualHandler.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import CoreLocation

class FactualHandler: NSObject {

    enum RestaurantType: Int {
        case Desert = 343
        case IceCream = 344
        case Buffet = 350
        case Burgers = 351
        case Diner = 354
        case FastFood = 355
        case Pizza = 363
    }
    
    static func getRestaurantData(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Restaurant {
        
        let urlPath: String = String(format: "http://api.v3.factual.com/t/restaurants-us?limit=1&q=\(name)&KEY=DIV1dOLSuWLgVyg2uEIVVgdq8FrskSxZnvHlWeZ7&geo={\"$point\":[%f,%f]}", latitude, longitude)
        var url: NSURL = NSURL(string: urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSError?
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
        
        var isHealthy = false
        
        if let response = jsonResult["response"] as? NSDictionary {
            if let data = response["data"] as? NSArray {
                if let restaurant = data[0] as? Dictionary<String, AnyObject> {
                    isHealthy = isHealthyFromJSON(restaurant)
                }
            }
        }
        
        return Restaurant(name: name, lat: latitude, long: longitude, isHealthy: isHealthy)
        
    }
    
    static func isHealthyFromJSON(restaurant: Dictionary<String, AnyObject>) -> Bool {
        
        if let ids = restaurant["category_ids"] as? NSArray {
            if let id = ids[0] as? Int {
                if (RestaurantType(rawValue: id) != nil) {
                    println("food is unhealthy")
                    return false
                } else {
                    println("food is healthy")
                    return true
                }
            }
        }
        
        return true
        
    }
    
    static func nearbyRestaurants(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Array<Restaurant>! {
        
        return [Restaurant(name: "", lat: 1, long: 1, isHealthy: false)]
        
    }
    
}
