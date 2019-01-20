//
//  PhotoDetailProtocol.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/20/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

//  A type that conforms to this protocol may be used in the RoverPhotoDetail_ViewController

protocol PhotoDetailProtocol {
    
    var photoURLString: String? { get }
    var photoCameraName: String? { get }
    var photoCameraFullName: String? { get }
    var photoRover: String? { get }
    var photoEarthDate: String? { get }
    var photoSolDate: Int? { get }
}
