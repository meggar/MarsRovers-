//
//  DataSourceHelpers.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

class DataSourceHelpers {
    
    
    static func apiKeyFromPlist(filename: String = "APIkeys") -> String? {
        
        struct APIKeyPlist: Codable {
            let NASA_api_key: String
        }
        
        if let url = Bundle.main.url(forResource: filename, withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListDecoder().decode(APIKeyPlist.self, from: data) {
            
            return plist.NASA_api_key
        }
        
        return nil
    }
    
    static func urlWith(endPoint: String, andParams params: [String:String]) -> URL? {
        
        var components = URLComponents(string: endPoint)
        
        components?.queryItems = params.map{ (key, value) in URLQueryItem(name: key, value: value) }
        
        return components?.url
    }
    
}
