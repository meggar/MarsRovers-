//
//  URLSessionProtocol.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation


// protocols to make URLSession mockable


protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }



protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionDataTaskProtocol {
        
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

// like URLSession.shared, but with a larger diskCapacity for cache.
extension URLSession {
    
    static let appSession: URLSession = {
        let config = URLSessionConfiguration.default
        let cache = URLCache(memoryCapacity: 4 * 1024 * 1024,
                             diskCapacity: 100 * 1024 * 1024,
                             diskPath: nil)
        config.urlCache = cache
        return URLSession(configuration: config)
    }()
}
