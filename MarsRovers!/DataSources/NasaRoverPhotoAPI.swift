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
    
    static let photoEndpoints:[RoverType:String] = [
        .curiosity: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos",
        .opportunity: "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos",
        .spirit: "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos"
    ]
    
    static let manifestEndpoints:[RoverType:String] = [
        .curiosity: "https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity",
        .opportunity: "https://api.nasa.gov/mars-photos/api/v1/manifests/opportunity",
        .spirit: "https://api.nasa.gov/mars-photos/api/v1/manifests/spirit"
    ]
    
    
    func getPhotosFor(rover: RoverType, onSolDate sol: Int, completion: @escaping (Photos?) -> ()) {
        
        if let apiKey = DataSourceHelpers.apiKeyFromPlist(),
            let route = NasaRoverPhotoAPI.photoEndpoints[rover],
            let url = DataSourceHelpers.urlWith(endPoint: route, andParams: ["sol": "\(sol)", "api_key": apiKey]) {

            let request = URLRequest(url: url)
            
            httpClient.get(request: request) { data in
                
                if let data = data {
                    completion(try? JSONDecoder().decode(Photos.self, from: data))
                }
                
            }
        }
        
    }
    
    
    func getManifestFor(rover: RoverType, completion: @escaping (RoverManifest?) -> ()) {
        
        if let apiKey = DataSourceHelpers.apiKeyFromPlist(),
            let route = NasaRoverPhotoAPI.manifestEndpoints[rover],
            let url = DataSourceHelpers.urlWith(endPoint: route, andParams: ["api_key": apiKey]) {
            
            let request = URLRequest(url: url)
            
            httpClient.get(request: request) { data in
                
                if let data = data {
                    completion(try? JSONDecoder().decode(RoverManifest.self, from: data))
                }
                
            }
        }
        
    }

}