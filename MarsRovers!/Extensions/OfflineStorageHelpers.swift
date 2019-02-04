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
        
        let imagePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(filename)"
            
        do {
            try image.pngData()?.write(to: URL(fileURLWithPath: imagePath))
        }catch{
            print("could not write file: \(filename)")
        }
    }
    
    
    func deleteImageFromDisk(filename: String) {
        
        let imagePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(filename)"
        
        do {
            try removeItem(at: URL(fileURLWithPath: imagePath))
        }catch{
            print("could not delete file: \(filename)")
        }
    }
}

