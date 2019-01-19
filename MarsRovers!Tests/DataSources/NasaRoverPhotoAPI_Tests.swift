//
//  NasaRoverPhotoAPI_Tests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/19/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
@testable import MarsRovers_

class NasaRoverPhotoAPI_Tests: XCTestCase {

    func testGetPhotosForRover() {
        
        guard let mockPhotos = MockPhotos(),
               let expectedData = mockPhotos.data  else { XCTFail(); return  }
        
 
        let mockSession = MockURLSession(
            data: expectedData,
            response: HTTPURLResponse(
                url: URL(string: "http://testing.com/test/1")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil),
            error: nil)
        

        let expectation = XCTestExpectation(description: "async response (Photos?) from NasaRoverPhotoAPI get request")
        let httpClient = HTTPClient(session: mockSession)
        let datasource = NasaRoverPhotoAPI(httpClient: httpClient)
        
        datasource.getPhotosFor(rover: .curiosity, onSolDate: 1) { photos in
            
            XCTAssertNotNil(photos)
            XCTAssertEqual(mockPhotos.photos, photos)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    
    func testGetManifestForRover() {
        
        guard let mockmanifest = MockManifest(),
            let expectedData = mockmanifest.data  else { XCTFail(); return  }
        
        
        let mockSession = MockURLSession(
            data: expectedData,
            response: HTTPURLResponse(
                url: URL(string: "http://testing.com/test/1")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil),
            error: nil)
        
        
        let expectation = XCTestExpectation(description: "async response (RoverManifest?) from NasaRoverPhotoAPI get request")
        let httpClient = HTTPClient(session: mockSession)
        let datasource = NasaRoverPhotoAPI(httpClient: httpClient)
        
        datasource.getManifestFor(rover: .curiosity) { manifest in
            
            XCTAssertNotNil(manifest)
            XCTAssertEqual(mockmanifest.manifest, manifest)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
