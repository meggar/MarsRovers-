//
//  UITest_Helpers.swift
//  MarsRovers!UITests
//
//  Created by Mike Eggar on 1/21/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func verify(element: XCUIElement, hasText text: String) {
        
        let predicate = NSPredicate(format: text)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(result, .completed, "\(element.identifier) != \(text)")
    }
}
