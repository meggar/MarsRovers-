//
//  Photos.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//
// generated by quicktype.io from json: https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=1000&api_key=DEMO_KEY

import Foundation


struct Photos: Codable & Equatable {
    let photos: [Photo]
}

struct Photo: Codable & Equatable {
    let id, sol: Int
    let camera: PhotoCamera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
}

struct PhotoCamera: Codable & Equatable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
}

struct Rover: Codable & Equatable {
    let id: Int
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [CameraElement]
    
    func description() -> String {
        return "\(name) rover was launched on \(launchDate), and landed on Mars on \(landingDate). Mission Status: \(status)."
    }
}

struct CameraElement: Codable & Equatable {
    let name, fullName: String
}


// MARK: - PhotoDetailProtocol conformance

extension Photo: PhotoDetailProtocol {
    var photoURLString: String? { return imgSrc }
    var photoCameraName: String? { return camera.name }
    var photoCameraFullName: String? { return camera.fullName }
    var photoRover: String? { return rover.name }
    var photoEarthDate: String? { return earthDate }
    var photoSolDate: Int? { return sol }
}
