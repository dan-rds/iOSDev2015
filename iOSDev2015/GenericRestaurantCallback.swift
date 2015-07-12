//
//  GenericRestaurantCallback.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import SenseSdk

enum RestaurantType: Int {
    case Desert = 343
    case IceCream = 344
    case Buffet = 350
    case Burgers = 351
    case Diner = 354
    case FastFood = 355
    case Pizza = 363
}

class GenericRestaurantCallback: NSObject, RecipeFiredDelegate {

    var notification: UILocalNotification?
    var types: Set<RestaurantType> = [.Desert, .IceCream, .Buffet, .Burgers, .Diner, .FastFood, .Pizza]
    
    @objc func recipeFired(args: RecipeFiredArgs) {

        println("recipe fired!")
        let place = args.triggersFired[0].places[0] as! PoiPlace
        let name = place.name
        let location = place.location
        let long = location.longitude
        let lat = location.latitude
        var isFastFood: Bool = false
        
        let jsonResult = FactualHandler.getRestaurantData(name, latitude: lat, longitude: long)
        
        if let response = jsonResult["response"] as? NSDictionary {
            if let data = response["data"] as? NSArray {
                if let restaurant = data[0] as? NSDictionary {
                    if let ids = restaurant["category_ids"] as? NSArray {
                        if let id = ids[0] as? Int {
                            if (RestaurantType(rawValue: id) != nil) {
                                println("food is unhealthy")
                                isFastFood = true
                            } else {
                                println("food is healthy")
                            }
                        }
                    }
                }
            }
        }
        
        let title: String? = "Warning!!!"
        let body: String? = isFastFood ? "Back off fatty... (Stay away from \(name))" : "Good job eating healthy... (Eating at \(name))"
        let date: NSDate = NSDate(timeIntervalSinceNow: 3)
        let dict: [NSString: AnyObject]? = ["lat": lat, "long": long, "name": name, "fastfood": isFastFood]
        
        notification = UILocalNotification()
        notification!.alertTitle = title
        notification!.alertBody = body
        notification!.fireDate = date
        notification!.timeZone = NSTimeZone.defaultTimeZone()
        notification!.userInfo = dict
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification!)
        
    }

}
