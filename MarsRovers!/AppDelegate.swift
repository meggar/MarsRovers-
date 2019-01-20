//
//  AppDelegate.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let roverSelector_ViewController = RoverSelector_ViewController()
        roverSelector_ViewController.moc = persistentContainer.viewContext
        roverSelector_ViewController.roverPhoto_DataSource = NasaRoverPhotoAPI(httpClient: HTTPClient())
        
        window?.rootViewController = UINavigationController(rootViewController: roverSelector_ViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
    

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "FavoriteImageModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

