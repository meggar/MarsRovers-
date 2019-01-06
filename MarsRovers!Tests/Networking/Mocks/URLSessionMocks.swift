//
//  URLSessionMocks.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation
@testable import MarsRovers_

struct MockDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}


struct MockURLSession: URLSessionProtocol {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionDataTaskProtocol {
        
        completionHandler(data, response, error)
        
        return MockDataTask()
    }
    
}
