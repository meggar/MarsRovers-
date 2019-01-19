//
//  RoverManifest.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

struct RoverManifest: Codable & Equatable {
    let photoManifest: PhotoManifest
    
    enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
    
    var firstSolDate: Int?  {
        return photoManifest.photos.min(by: { $0.sol < $1.sol })?.sol
    }
    
    var lastSolDate: Int? {
        return photoManifest.photos.max(by: { $0.sol < $1.sol })?.sol
    }
}

struct PhotoManifest: Codable & Equatable {
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let photos: [PhotoInfo]
    
    enum CodingKeys: String, CodingKey {
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case photos
    }
}

struct PhotoInfo: Codable & Equatable {
    let sol, totalPhotos: Int
    let earthDate: String?
    let cameras: [Camera]
    
    enum CodingKeys: String, CodingKey {
        case sol
        case earthDate = "earth_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

enum Camera: String, Codable {
    case entry = "ENTRY"
    case fhaz = "FHAZ"
    case minites = "MINITES"
    case navcam = "NAVCAM"
    case pancam = "PANCAM"
    case rhaz = "RHAZ"
    case chemcam = "CHEMCAM"
    case mahli = "MAHLI"
    case mardi = "MARDI"
    case mast = "MAST"
}
