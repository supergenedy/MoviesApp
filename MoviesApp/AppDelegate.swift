//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Ahmed on 8/13/19.
//  Copyright © 2019 supergenedy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let dataController = DataController(modelName: "FavouritMovies")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        dataController.load()
        
        return true
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        try? dataController.viewContext.save()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        try? dataController.viewContext.save()
    }
    
}

