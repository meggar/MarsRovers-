//
//  OfflineStorageHelpers.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 2/3/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation
import UIKit

extension FileManager {


    func saveImageToDisk(image: UIImage, filename: String) {
        
        let imagePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(filename).png"
            
        try? image.pngData()?.write(to: URL(fileURLWithPath: imagePath))
    }
    
    
    func deleteImageFromDisk(filename: String) {
        
        let imagePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(filename).png"
            
        try? FileManager.default.removeItem(at: URL(fileURLWithPath: imagePath))
    }
}

