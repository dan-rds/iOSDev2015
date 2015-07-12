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

        NSLog("recipe fired!")
        let place = args.triggersFired[0].places[0] as! PoiPlace
        let name = place.id //will be place.name after update
        let location = place.location
        let long = location.longitude
        let lat = location.latitude
        var isFastFood: Bool = false
        
        let urlPath: String = "http://api.v3.factual.com/t/restaurants-us?limit=1&q=\(name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)&KEY=DIV1dOLSuWLgVyg2uEIVVgdq8FrskSxZnvHlWeZ7"
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
        var err: NSError?
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
        
        if let response = jsonResult["response"] as? NSDictionary {
            if let data = response["data"] as? NSArray {
                if let restaurant = data[0] as? NSDictionary {
                    println(restaurant)
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
