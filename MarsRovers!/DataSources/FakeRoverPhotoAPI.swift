//
//  FakeRoverPhotoAPI.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation


// a fake network API to use while developing the UI

class FakeRoverPhotoAPI: RoverPhoto_DataSource {

    
    func getPhotosFor(rover: RoverType, completion: @escaping (Photos?) -> ()) {

        let filepaths:[RoverType:String] = [
            .curiosity: "FakeJson_Curiosity",
            .opportunity: "FakeJson_Opportunity",
            .spirit: "FakeJson_Spirit"
            ]
        
        if let path = Bundle.main.path(forResource: filepaths[rover], ofType: "json"),
            let text = try? String(contentsOfFile: path),
            let data = text.data(using: .utf8) {

            completion( try? JSONDecoder().decode(Photos.self, from: data) )
            
        }else{
            completion(nil)
        }
        
    }

}
