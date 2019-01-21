//
//  Photos_Tests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
@testable import MarsRovers_

class Photos_Tests: XCTestCase {

    var jsonStrings: [String] = []
    
    override func setUp() {
        
        ["FakeJson_CuriosityPhotos",
         "FakeJson_OpportunityPhotos",
         "FakeJson_SpiritPhotos"].forEach{ filepath in
                            
            guard let path = Bundle.main.path(forResource: filepath, ofType: "json"),
                   let jsonText = try? String(contentsOfFile: path)
                else {
                    XCTFail();
                    return
            }
                            
            jsonStrings.append(jsonText)
        }
    }
    
    override func tearDown() {
        jsonStrings.removeAll()
    }
    
    
    // Test that a Photos model will be created with JSONDecoder using the test json.
    func testPhotosFromJson() {
        
        XCTAssertEqual(jsonStrings.count, 3)
        
        jsonStrings.forEach{ json in
            
            guard let data = json.data(using: .utf8),
                let _ = try? JSONDecoder().decode(Photos.self, from: data)
                
                else {
                    XCTFail();
                    return
            }
        }
    }

}
