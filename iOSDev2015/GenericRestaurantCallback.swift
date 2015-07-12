//
//  GenericRestaurantCallback.swift
//  
//
//  Created by Adam Van Prooyen on 7/11/15.
//
//

import Foundation
import SenseSdk


class GenericRestaurantCallback: NSObject, RecipeFiredDelegate, FactualAPIDelegate {

    var notification: UILocalNotification?
    
    @objc func recipeFired(args: RecipeFiredArgs) {
        
        NSLog("recipe fired!")
        
        let place = args.triggersFired[0].places[0] as! PoiPlace
        let name = place.id //will be place.name after update
        let location = place.location
        let long = location.longitude
        let lat = location.latitude
        var isFastFood: Bool = false
        
        if (name == "McDonalds") {
            isFastFood = true
        }
        
        let title: String? = "Warning!!!"
        let body: String? = isFastFood ? "Back off fatty... (Stay away from \(name))" : "Good job eating healthy... (Eating at \(name))"
        let date: NSDate = NSDate(timeIntervalSinceNow: 10)
        let dict: [NSString: AnyObject]? = ["lat": lat, "long": long, "name": name, "fastfood": isFastFood]
        
        notification = UILocalNotification()
        notification!.alertTitle = title
        notification!.alertBody = body
        notification!.fireDate = date
        notification!.timeZone = NSTimeZone.defaultTimeZone()
        notification!.userInfo = dict
        
        let fact = FactualAPI(APIKey: "DIV1dOLSuWLgVyg2uEIVVgdq8FrskSxZnvHlWeZ7", secret: "n1tE6gak9cVLB20rpJKd1bPQUZo2P35ocu4xUbGI")
        fact.getTableSchema("restaurants-us", withDelegate: self)
        
        let query = FactualQuery()
        query.addFullTextQueryTerm("mcdonalds")
        query.includeRowCount = true
        
        fact.queryTable("restaurants-us", optionalQueryParams: query, withDelegate: self)
        
        
        
    }
    
    func requestComplete(request: FactualAPIRequest!, failedWithError error: NSError!) {
        
    }
    
    func requestComplete(request: FactualAPIRequest!, receivedMatchResult factualId: String!) {
        
    }
    
    func requestComplete(request: FactualAPIRequest!, receivedQueryResult queryResult: FactualQueryResult!) {
        
        NSLog("%@", queryResult)
        UIApplication.sharedApplication().scheduleLocalNotification(notification!)
        
    }
    
    func requestComplete(request: FactualAPIRequest!, receivedRawResult result: [NSObject : AnyObject]!) {
        
    }
    
}
