//
//  GenericRestaurantCallback.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import SenseSdk


class GenericRestaurantCallback: RecipeFiredDelegate {

    @objc func recipeFired(args: RecipeFiredArgs) {
        
        NSLog("recipe fired!")
        
        let place = args.triggersFired[0].places[0] as! PoiPlace
        let name = place.id
        let location = place.location
        let long = location.longitude
        let lat = location.latitude
        
        let title: String? = "Warning!!!"
        let body: String? = "Back off fatty... (Stay away from \(name))"
        let date: NSDate = NSDate(timeIntervalSinceNow: 5)
        let dict: [NSString: AnyObject]? = ["lat": lat, "long": long, "name": name]
        
        let notification = UILocalNotification()
        notification.alertTitle = title
        notification.alertBody = body
        notification.fireDate = date
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.userInfo = dict
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
}
