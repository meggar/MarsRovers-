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

    
    
    func getPhotosFor(rover: RoverType, on earthdate: String) -> Photos? {
        
        
        let json  =
        """
{"photos":[{"id":301536,"sol":1000,"camera":{"id":29,"name":"NAVCAM","rover_id":7,"full_name":"Navigation Camera"},"img_src":"http://mars.nasa.gov/mer/gallery/all/2/n/1000/2N215136972EDNAS00P1585L0M1-BR.JPG","earth_date":"2006-10-27","rover":{"id":7,"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"PANCAM","full_name":"Panoramic Camera"},{"name":"MINITES","full_name":"Miniature Thermal Emission Spectrometer (Mini-TES)"},{"name":"ENTRY","full_name":"Entry, Descent, and Landing Camera"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}},{"id":301537,"sol":1000,"camera":{"id":29,"name":"NAVCAM","rover_id":7,"full_name":"Navigation Camera"},"img_src":"http://mars.nasa.gov/mer/gallery/all/2/n/1000/2N215137010EDNAS00P1585L0M1-BR.JPG","earth_date":"2006-10-27","rover":{"id":7,"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"PANCAM","full_name":"Panoramic Camera"},{"name":"MINITES","full_name":"Miniature Thermal Emission Spectrometer (Mini-TES)"},{"name":"ENTRY","full_name":"Entry, Descent, and Landing Camera"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}},{"id":301538,"sol":1000,"camera":{"id":29,"name":"NAVCAM","rover_id":7,"full_name":"Navigation Camera"},"img_src":"http://mars.nasa.gov/mer/gallery/all/2/n/1000/2N215137048EDNAS00P1585L0M1-BR.JPG","earth_date":"2006-10-27","rover":{"id":7,"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"PANCAM","full_name":"Panoramic Camera"},{"name":"MINITES","full_name":"Miniature Thermal Emission Spectrometer (Mini-TES)"},{"name":"ENTRY","full_name":"Entry, Descent, and Landing Camera"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}},{"id":301539,"sol":1000,"camera":{"id":29,"name":"NAVCAM","rover_id":7,"full_name":"Navigation Camera"},"img_src":"http://mars.nasa.gov/mer/gallery/all/2/n/1000/2N215137086EDNAS00P1585L0M1-BR.JPG","earth_date":"2006-10-27","rover":{"id":7,"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"PANCAM","full_name":"Panoramic Camera"},{"name":"MINITES","full_name":"Miniature Thermal Emission Spectrometer (Mini-TES)"},{"name":"ENTRY","full_name":"Entry, Descent, and Landing Camera"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}},{"id":341822,"sol":1000,"camera":{"id":30,"name":"PANCAM","rover_id":7,"full_name":"Panoramic Camera"},"img_src":"http://mars.nasa.gov/mer/gallery/all/2/p/1000/2P215138639ESFAS00P2600L8M1-BR.JPG","earth_date":"2006-10-27","rover":{"id":7,"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"PANCAM","full_name":"Panoramic Camera"},{"name":"MINITES","full_name":"Miniature Thermal Emission Spectrometer (Mini-TES)"},{"name":"ENTRY","full_name":"Entry, Descent, and Landing Camera"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}},{"id":341823,"sol":1000,"camera":{"id":30,"name":"PANCAM","rover_id":7,"full_name":"Panoramic Camera"},"img_src":"http://mars.nasa.gov/mer/gallery/all/2/p/1000/2P215138639ESFAS00P2600R8M1-BR.JPG","earth_date":"2006-10-27","rover":{"id":7,"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"PANCAM","full_name":"Panoramic Camera"},{"name":"MINITES","full_name":"Miniature Thermal Emission Spectrometer (Mini-TES)"},{"name":"ENTRY","full_name":"Entry, Descent, and Landing Camera"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}}]}
"""
        
        guard let data = json.data(using: .utf8) else { return nil }
        
        return try? JSONDecoder().decode(Photos.self, from: data)
        
    }
    
    
}