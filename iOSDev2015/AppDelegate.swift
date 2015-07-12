//
//  AppDelegate.swift
//  iOSDev2015
//
//  Created by Daniel Richards on 7/11/15.
//  Copyright (c) 2015 Daniel Richards. All rights reserved.
//

import UIKit
import SenseSdk
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FactualHandler.nearbyRestaurantsAtLatitude(37.375174, longitude: -121.918564, count: 10)
        
        //enables local notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))
        
        //set up sensesdk and initial recipe registration
        SenseSdk.enableSdkWithKey("SDK KEY HERE")
        
        let restaurantTrigger = FireTrigger.whenEntersPoi(.Restaurant, conditions: nil, errorPtr: nil)!
        
        let recipe = Recipe(name: "restaurantRecipe", trigger: restaurantTrigger, timeWindow: TimeWindow.allDay, cooldown: Cooldown.create(oncePer: 10, frequency: CooldownTimeUnit.Minutes, errorPtr: nil)!)
        
        let callback = GenericRestaurantCallback()
        
        SenseSdk.register(recipe: recipe, delegate: callback)
        
        return true
    }
    
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        println("Notification recieved")
        
        let controller = window!.rootViewController as! ViewController
        controller.handleNotification(notification)
        
    }


}

