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
        roverSelector_ViewController.roverPhoto_DataSource = ProcessInfo.processInfo.arguments.contains("fakeAPI")
                                                             ? FakeRoverPhotoAPI()
                                                             : NasaRoverPhotoAPI(httpClient: HTTPClient())
        
        window?.rootViewController = UINavigationController(rootViewController: roverSelector_ViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
    

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {

        if !ProcessInfo.processInfo.arguments.contains("fakeCoreData") {
            
            // create the normal core data stack
            
            let container = NSPersistentContainer(name: "FavoriteImageModel")
            container.loadPersistentStores(){ (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
         
        } else {
            
            // create a blank canvas for XCUITests, only using in-memory storage.
            
            let container = NSPersistentContainer(name: "FavoriteImageModel")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false
            
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (description, error) in
                
                precondition( description.type == NSInMemoryStoreType )
                if let error = error {
                    fatalError("could not create fake Core Data")
                }
            }
            
            // insert a few Favorited photos into the fake Core Data
            
            for photo in FakeRoverPhotoAPI().getSomeTestPhotos(count: 3) {
            
                let newObject = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRoverImage", into: container.viewContext)
            
                newObject.setValue(photo.photoId, forKey: "imageId")
                newObject.setValue(photo.photoURLString, forKey: "urlString")
                newObject.setValue(photo.photoRover, forKey: "rover")
                newObject.setValue(photo.photoEarthDate, forKey: "earthDate")
                newObject.setValue(photo.photoSolDate, forKey: "solDate")
                newObject.setValue(photo.photoCameraName, forKey: "camera")
                newObject.setValue(photo.photoCameraFullName, forKey: "cameraFullname")
            
                // try! is OK here because the app has been launched from XCUITest
                try! container.viewContext.save()
            }
            
            return container
        }
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

