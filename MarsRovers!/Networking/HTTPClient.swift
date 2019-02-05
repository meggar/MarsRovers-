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
            
            if error == nil,
                let response = response as? HTTPURLResponse,
                (200...299) ~= response.statusCode {
                
                completion(data)
            }else{
                completion(nil)
            }
            
        }
        
        task.resume()    
    }
 
    init(session: URLSessionProtocol = URLSession.appSession) {
        self.session = session
    }
    
}
