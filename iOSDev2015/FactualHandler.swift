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
    
    static func getRestaurantData(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Restaurant? {
        
        let urlPath: String = String(format: "http://api.v3.factual.com/t/restaurants-us?limit=1&q=\(name)&KEY=DIV1dOLSuWLgVyg2uEIVVgdq8FrskSxZnvHlWeZ7&geo={\"$point\":[%f,%f]}", latitude, longitude)
        var url: NSURL = NSURL(string: urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        
        let jsonResult = jsonForURL(url)
        
        if let response = jsonResult["response"] as? [String: AnyObject] {
            if let restaurants = response["data"] as? [[String: AnyObject]] {
                if let restaurant = restaurants[0] as [String: AnyObject]! {
                    return restaurantFromJSON(restaurant)
                }
            }
        }
        
        return nil
        
    }
    
    static func restaurantFromJSON(restaurant: [String: AnyObject]) -> Restaurant? {
        
        var name = ""
        var latitude = 0.0
        var longitude = 0.0
        var isHealthy = false
        
        if let n = restaurant["name"] as? String {
            name = n
        }
        
        if let lat = restaurant["latitude"] as? Double {
            latitude = lat
        }
        
        if let long = restaurant["longitude"] as? Double {
            longitude = long
        }
        
        if let ids = restaurant["category_ids"] as? NSArray {
            if let id = ids[0] as? Int {
                if (RestaurantType(rawValue: id) != nil) {
                    println("food is unhealthy")
                    isHealthy = false
                } else {
                    println("food is healthy")
                    isHealthy = true
                }
            }
        }
        
        return Restaurant(name: name, lat: latitude, long: longitude, isHealthy: isHealthy)
        
    }
    
    static func nearbyRestaurantsAtLatitude(latitude: CLLocationDegrees, longitude: CLLocationDegrees, count: Int) -> [Restaurant]! {
        
        let urlPath: String = String(format: "http://api.v3.factual.com/t/restaurants-us?limit=\(count)&KEY=DIV1dOLSuWLgVyg2uEIVVgdq8FrskSxZnvHlWeZ7&geo={\"$circle\":{\"$center\":[%f,%f],\"$meters\":2000}}&filters={\"category_ids\":{\"$excludes_any\":[343,344,350,351,354,355,363]}}", latitude, longitude)
        var url: NSURL = NSURL(string: urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        
        let json = jsonForURL(url)
        var restaurantArray: [Restaurant] = []
        
        if let response = json["response"] as? [String: AnyObject] {
            if let restaurants = response["data"] as? [[String: AnyObject]] {
                for restaurant in restaurants {
                    restaurantArray.append(restaurantFromJSON(restaurant)!)
                }
            }
        }
        
        println(restaurantArray)
        
        return restaurantArray
        
    }
    
    static func jsonForURL(url: NSURL) -> NSDictionary {
        
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSError?
        
        return (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
        
    }
    
}
