//
//  JSONDecoderExtensions.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 2/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    convenience init(withStrategy: KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
}
