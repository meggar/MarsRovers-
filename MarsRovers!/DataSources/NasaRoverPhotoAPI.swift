//
//  NasaMarsRoverAPI.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

class NasaRoverPhotoAPI: RoverPhoto_DataSource {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    static let routes:[RoverType:String] = [
        .curiosity: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos",
        .opportunity: "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos",
        .spirit: "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos"
    ]
    
    func getPhotosFor(rover: RoverType, completion: @escaping (Photos?) -> ()) {
        
        if let earthDate = DataSourceHelpers.formattedDateString(daysAgo: 2000),
            let apiKey = DataSourceHelpers.apiKeyFromPlist(),
            let route = NasaRoverPhotoAPI.routes[rover],
            let url = DataSourceHelpers.urlWith(endPoint: route, andParams: ["earth_date": earthDate, "api_key": apiKey]) {
        
            let request = URLRequest(url: url)
            
            httpClient.get(request: request) { data in
                
                if let data = data {
                    completion(try? JSONDecoder().decode(Photos.self, from: data))
                }
                
            }
        }
        
    }
    
    
    

}
