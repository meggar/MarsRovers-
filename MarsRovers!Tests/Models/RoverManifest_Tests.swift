//
//  RoverManifest_Tests.swift
//  MarsRovers!Tests
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import XCTest
@testable import MarsRovers_

class RoverManifest_Tests: XCTestCase {

    func testExample() {
        
        let json =
        """
        {"photo_manifest":{"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"photos":[{"sol":1,"total_photos":77,"cameras":["ENTRY","FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":2,"total_photos":125,"cameras":["MINITES","NAVCAM","PANCAM"]},{"sol":3,"total_photos":125,"cameras":["NAVCAM","PANCAM","RHAZ"]},{"sol":4,"total_photos":143,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":5,"total_photos":353,"cameras":["NAVCAM","PANCAM"]},{"sol":6,"total_photos":346,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":7,"total_photos":137,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":8,"total_photos":182,"cameras":["FHAZ","PANCAM","RHAZ"]},{"sol":9,"total_photos":353,"cameras":["NAVCAM","PANCAM"]},{"sol":10,"total_photos":186,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]}]}}
        """
        

        guard let data = json.data(using: .utf8),
            let _ = try? JSONDecoder().decode(RoverManifest.self, from: data)
            
            else {
                XCTFail();
                return
        }
        
    }

}
