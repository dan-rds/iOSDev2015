//
//  GenericRestaurantCallback.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import SenseSdk

class GenericRestaurantCallback: NSObject, RecipeFiredDelegate {

    var notification: UILocalNotification?
    
    @objc func recipeFired(args: RecipeFiredArgs) {

        println("recipe fired!")
        let place = args.triggersFired[0].places[0] as! PoiPlace
        let name = place.name
        let location = place.location
        let long = location.longitude
        let lat = location.latitude
        
        let restaurant = FactualHandler.getRestaurantData(name, latitude: lat, longitude: long)!
        
        let title: String? = "Warning!!!"
        let body: String? = restaurant.isHealthy ? "Good job eating healthy... (Eating at \(name))" : "Back off fatty... (Stay away from \(name))"
        let date: NSDate = NSDate(timeIntervalSinceNow: 3)
        let dict: [NSString: AnyObject]? = ["lat": lat, "long": long, "name": name, "fastfood": !restaurant.isHealthy]
        
        notification = UILocalNotification()
        notification!.alertTitle = title
        notification!.alertBody = body
        notification!.fireDate = date
        notification!.timeZone = NSTimeZone.defaultTimeZone()
        notification!.userInfo = dict
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification!)
        
    }

}
