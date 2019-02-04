//
//  DataSourceHelpers_Tests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
@testable import MarsRovers_

class DataSourceHelpers_Tests: XCTestCase {

    
    func testApiKeyFromPlist() {

        XCTAssertNotNil(DataSourceHelpers.apiKeyFromPlist())
    }
    
    
    func testUrlWith() {
        
        guard let result = DataSourceHelpers.urlWith(endPoint: "https:/test/test",
                                                     andParams: ["param1": "value1", "param2": "value2"])
            else { XCTFail(); return }
        
        
        let possibleExpectations = ["https:/test/test?param1=value1&param2=value2",
                        "https:/test/test?param2=value2&param1=value1"]
        
        XCTAssertTrue(possibleExpectations.contains(result.absoluteString))
    }
    
}
