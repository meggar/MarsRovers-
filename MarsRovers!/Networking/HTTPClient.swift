//
//  HTTPClient.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

class HTTPClient {
    
    let session: URLSessionProtocol
    
    func get(request: URLRequest, completion: @escaping (Data?) -> ()) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            completion(data)
            
        }
        
        task.resume()    
    }
 
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
}
