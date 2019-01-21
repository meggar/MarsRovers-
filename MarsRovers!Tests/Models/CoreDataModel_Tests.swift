//
//  PhotoDetailProtocolConformance_Tests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/21/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
import CoreData

@testable import MarsRovers_

class CoreDataModel_Tests: XCTestCase {
    
    
    // Test the FavoriteImageModel core data model structure.
    func testFavoriteRoverImage() {

        let moc = NSPersistentContainer(name: "FavoriteImageModel").viewContext
        
        let newObject = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRoverImage", into: moc)
        
        newObject.setValuesForKeys([
             "urlString": "",
             "rover": "",
             "earthDate": "",
             "solDate": 0,
             "camera": "",
             "cameraFullname": ""
            ])
        
        XCTAssertNotNil(newObject as? FavoriteRoverImage, "Error creating FavoriteRoverImage model")
        
        XCTAssertNotNil(newObject as? PhotoDetailProtocol, "CoreData model FavoriteRoverImage should conform to PhotoDetailProtocol")
    }
}
