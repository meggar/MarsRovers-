//
//  ModelMocks.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/19/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation
@testable import MarsRovers_

struct MockPhotos {
    
    var photos: Photos
    var data: Data? { return try? JSONEncoder().encode(photos) }
    
    init?() {
        
        if let path = Bundle.main.path(forResource: "FakeJson_CuriosityPhotos", ofType: "json"),
            let text = try? String(contentsOfFile: path),
            let data = text.data(using: .utf8),
            let photos = try? JSONDecoder().decode(Photos.self, from: data) {
            
            self.photos = photos
            
        }else{
            return nil
        }
    }
}

struct MockManifest {
    
    var manifest: RoverManifest
    var data: Data? { return try? JSONEncoder().encode(manifest) }
    
    init? () {
        
        if let path = Bundle.main.path(forResource: "FakeJson_CuriosityManifest", ofType: "json"),
            let text = try? String(contentsOfFile: path),
            let data = text.data(using: .utf8),
            let manifest = try? JSONDecoder().decode(RoverManifest.self, from: data) {
            
            self.manifest = manifest
            
        }else{
            return nil
        }
    }
    
}
