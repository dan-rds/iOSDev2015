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
        
        let title: String? = "Warning!!!"
        let body: String? = "Back off fatty"
        let date: NSDate = NSDate(timeIntervalSinceNow: 10.0)
        
        let notification = UILocalNotification()
        notification.alertTitle = title
        notification.alertBody = body
        notification.fireDate = date
        notification.timeZone = NSTimeZone.defaultTimeZone()
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
}
