//
//  RoverPhoto_DataSource.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

protocol RoverPhoto_DataSource {
    
    func getPhotosFor(rover: RoverType, completion: @escaping (Photos?) -> ())
    
}
