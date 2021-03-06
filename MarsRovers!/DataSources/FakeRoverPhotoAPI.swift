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

    // MARK: - RoverPhoto_DataSource
    
    func getPhotosFor(rover: RoverType, onSolDate sol: Int, completion: @escaping (Photos?) -> ()) {

        let photos:[RoverType:String] = [
            .curiosity: "FakeJson_CuriosityPhotos",
            .opportunity: "FakeJson_OpportunityPhotos",
            .spirit: "FakeJson_SpiritPhotos"
        ]
        
        if let path = Bundle.main.path(forResource: photos[rover], ofType: "json"),
            let text = try? String(contentsOfFile: path),
            let data = text.data(using: .utf8) {

            completion( try? JSONDecoder(withStrategy: .convertFromSnakeCase).decode(Photos.self, from: data) )
            
        }else{
            completion(nil)
        }
    }
    
    func getManifestFor(rover: RoverType, completion: @escaping (RoverManifest?) -> ()) {
        
        let manifests:[RoverType:String] = [
            .curiosity: "FakeJson_CuriosityManifest",
            .opportunity: "FakeJson_OpportunityManifest",
            .spirit: "FakeJson_SpiritManifest"
        ]
        
        if let path = Bundle.main.path(forResource: manifests[rover], ofType: "json"),
            let text = try? String(contentsOfFile: path),
            let data = text.data(using: .utf8) {
            
            completion( try? JSONDecoder(withStrategy: .convertFromSnakeCase).decode(RoverManifest.self, from: data) )
            
        }else{
            completion(nil)
        }
    }

    func getImageData(photo: PhotoDetailProtocol, completion: @escaping (Data?) -> ()) {
        
        if let fakeImageURL = Bundle.main.url(forResource: "TestImage", withExtension: "png"),
            let data = try? Data(contentsOf: fakeImageURL) {
            
            completion(data)
        }
    }
    
    
    // MARK: - Testing helpers
    
    func getSomeTestPhotos(count: Int) -> [Photo] {
        
        var photos:[Photo] = []

        if let path = Bundle.main.path(forResource: "FakeJson_CuriosityPhotos", ofType: "json"),
            let text = try? String(contentsOfFile: path),
            let data = text.data(using: .utf8) {
            
            if let fakePhotos = try? JSONDecoder(withStrategy: .convertFromSnakeCase).decode(Photos.self, from: data).photos.prefix(count) {
                photos.append(contentsOf: fakePhotos)
            }
        }
        
        return photos
    }
    
}
