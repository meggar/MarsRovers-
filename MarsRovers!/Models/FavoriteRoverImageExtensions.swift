//
//  FavoriteImageExtensions.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/20/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation


// Allows FavoriteRoverImage to be used in the RoverPhotoDetail_ViewController

extension FavoriteRoverImage: PhotoDetailProtocol {
    
    var photoURLString: String? { return urlString }
    var photoCameraName: String? { return camera }
    var photoCameraFullName: String? { return camera }
    var photoRover: String? { return rover }
    var photoEarthDate: String? { return earthDate }
    var photoSolDate: Int? { return Int(solDate) }
    
}
