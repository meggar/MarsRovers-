//
//  UITest_Helpers.swift
//  MarsRovers!UITests
//
//  Created by Mike Eggar on 1/21/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest

struct UITestHelpers {
    
    static func check(element: XCUIElement, expectedText: String) {
    
        let predicate = NSPredicate(format: expectedText)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
    
        XCTAssertEqual(result, .completed, "\(element.identifier) != \(expectedText)")
    }
}

