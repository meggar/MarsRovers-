//
//  AppDelegate.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let roverSelector_ViewController = RoverSelector_ViewController()
        roverSelector_ViewController.roverPhoto_DataSource = NasaRoverPhotoAPI(httpClient: HTTPClient())
        
        window?.rootViewController = UINavigationController(rootViewController: roverSelector_ViewController)
        window?.makeKeyAndVisible()
        
        return true
    }


}

