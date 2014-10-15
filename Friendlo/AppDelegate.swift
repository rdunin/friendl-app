//
//  AppDelegate.swift
//  Friendlo
//
//  Created by Alona Demochko on 03.10.14.
//  Copyright (c) 2014 kybydev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        configureAppearance()
        
        Parse.setApplicationId("PmHCNIasLlRB7WwHCfZFYyPaYwtPEWaTi7kuNo2e", clientKey:"GDuv35lbDERyzrG3XW6NxowOem1Gb7t7cs91eRF5")
        PFFacebookUtils.initializeFacebook()
        
        FBLoginView.self
        FBProfilePictureView.self
        
        return true
    }
    
    func configureAppearance() {
        
        //UINavigationBar.appearance().barTintColor = UIColor(red: 31.0/255.0, green: 58.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0/255.0, green: 51.0/255.0, blue: 153.0/255.0, alpha: 0.8)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), NSForegroundColorAttributeName: UIColor(red: 41.0/255.0, green: 128.0/255.0, blue: 185.0/255.0, alpha: 1)]
        
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }
    
    func applicationDidBecomeActive(application: UIApplication?) {
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }

}

