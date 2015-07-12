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

    static func getRestaurantData(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Dictionary<String, AnyObject> {
        
        let urlPath: String = String(format: "http://api.v3.factual.com/t/restaurants-us?limit=1&q=\(name)&KEY=DIV1dOLSuWLgVyg2uEIVVgdq8FrskSxZnvHlWeZ7&geo={\"$point\":[%f,%f]}", latitude, longitude)
        var url: NSURL = NSURL(string: urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSError?
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
        
        return jsonResult as! Dictionary
        
    }
    
    
    
}
