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
        
        [
        """
        {"photo_manifest":{"name":"Spirit","landing_date":"2004-01-04","launch_date":"2003-06-10","status":"complete","max_sol":2208,"max_date":"2010-03-21","total_photos":124550,"photos":[{"sol":1,"total_photos":77,"cameras":["ENTRY","FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":2,"total_photos":125,"cameras":["MINITES","NAVCAM","PANCAM"]},{"sol":3,"total_photos":125,"cameras":["NAVCAM","PANCAM","RHAZ"]},{"sol":4,"total_photos":143,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":5,"total_photos":353,"cameras":["NAVCAM","PANCAM"]},{"sol":6,"total_photos":346,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":7,"total_photos":137,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":8,"total_photos":182,"cameras":["FHAZ","PANCAM","RHAZ"]},{"sol":9,"total_photos":353,"cameras":["NAVCAM","PANCAM"]},{"sol":10,"total_photos":186,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]}]}}
        """
        ,
        
        """
        {"photo_manifest":{"name":"Opportunity","landing_date":"2004-01-25","launch_date":"2003-07-07","status":"active","max_sol":5111,"max_date":"2018-06-11","total_photos":198439,"photos":[{"sol":1,"earth_date":"2004-01-26","total_photos":95,"cameras":["ENTRY","FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":2,"earth_date":"2004-01-27","total_photos":280,"cameras":["MINITES","NAVCAM","PANCAM"]},{"sol":3,"earth_date":"2004-01-28","total_photos":321,"cameras":["NAVCAM","PANCAM","RHAZ"]},{"sol":4,"earth_date":"2004-01-29","total_photos":274,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":5,"earth_date":"2004-01-30","total_photos":97,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":6,"earth_date":"2004-01-31","total_photos":34,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":7,"earth_date":"2004-02-01","total_photos":143,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":8,"earth_date":"2004-02-02","total_photos":95,"cameras":["FHAZ","PANCAM","RHAZ"]},{"sol":9,"earth_date":"2004-02-03","total_photos":43,"cameras":["FHAZ","MINITES","PANCAM"]},{"sol":10,"earth_date":"2004-02-04","total_photos":206,"cameras":["FHAZ","MINITES","PANCAM"]},{"sol":11,"earth_date":"2004-02-05","total_photos":223,"cameras":["FHAZ","PANCAM"]},{"sol":12,"earth_date":"2004-02-06","total_photos":172,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":13,"earth_date":"2004-02-07","total_photos":184,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":14,"earth_date":"2004-02-08","total_photos":199,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":15,"earth_date":"2004-02-09","total_photos":185,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM"]},{"sol":16,"earth_date":"2004-02-10","total_photos":109,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":17,"earth_date":"2004-02-11","total_photos":261,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":18,"earth_date":"2004-02-12","total_photos":154,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":19,"earth_date":"2004-02-13","total_photos":175,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":20,"earth_date":"2004-02-14","total_photos":246,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":21,"earth_date":"2004-02-15","total_photos":134,"cameras":["FHAZ","NAVCAM","PANCAM","RHAZ"]},{"sol":22,"earth_date":"2004-02-16","total_photos":128,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM"]},{"sol":23,"earth_date":"2004-02-17","total_photos":226,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]},{"sol":24,"earth_date":"2004-02-18","total_photos":142,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM"]},{"sol":25,"earth_date":"2004-02-19","total_photos":45,"cameras":["FHAZ","MINITES","PANCAM"]},{"sol":26,"earth_date":"2004-02-20","total_photos":202,"cameras":["FHAZ","MINITES","NAVCAM","PANCAM","RHAZ"]}]}}
        """
        ].forEach{ json in

            guard let data = json.data(using: .utf8),
                let _ = try? JSONDecoder().decode(RoverManifest.self, from: data)
            
                else {
                    XCTFail();
                    return
            }
            
        }
        
    }

}
