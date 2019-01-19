//
//  HTTPClientTests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
@testable import MarsRovers_

class HTTPClientTests: XCTestCase {

    func testGet() {
        
        let expectedData = "{\"key1\":\"value1\"}".data(using: .utf8)
        
        let mockSession = MockURLSession(
                data: expectedData,
                response: HTTPURLResponse(
                    url: URL(string: "http://testing.com/test/1")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil),
                error: nil)
        
        
        let httpClient = HTTPClient(session: mockSession)
        
        let expectation = XCTestExpectation(description: "async response from get request")
        
        guard let url = URL(string: "test_url") else { XCTFail(); return }
        
        let request = URLRequest(url: url)
        
        httpClient.get(request: request) { data in
            
            XCTAssertNotNil(data)
            XCTAssertEqual(data, expectedData)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }

}
