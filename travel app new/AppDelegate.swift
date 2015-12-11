//
//  AppDelegate.swift
//  travel app new
//
//  Created by tusher on 11/20/15.
//  Copyright © 2015 tusher. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().backgroundColor = UIColor.whiteColor()
               UINavigationBar.appearance().backItem?.title = nil
        GMSServices.provideAPIKey("AIzaSyCMpXEwpmeAkhLqXdSZ0vHJe0EtVXocgWw");
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
       
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
            }


}

