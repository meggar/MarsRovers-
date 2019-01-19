//
//  FakeRoverPhotoAPI_Tests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/19/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
@testable import MarsRovers_

class FakeRoverPhotoAPI_Tests: XCTestCase {

    func testGetPhotosForRover() {
        
        let expectation = XCTestExpectation(description: "async response (Photos?) from FakeRoverPhotoAPI get request")
        
        let datasource = FakeRoverPhotoAPI()
        
        datasource.getPhotosFor(rover: .curiosity, onSolDate: 1) { photos in
            
            XCTAssertNotNil(photos)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

}
