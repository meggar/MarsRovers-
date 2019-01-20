//
//  StyleExtensions.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/19/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import Foundation
import UIKit

// Colors and Fonts to be used throughout the app.

extension UIColor {
    static let appWhite = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let appBlue = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
}

extension UIFont {
    static let appFontSmall = UIFont(name: "AvenirNext-Light", size: 14.0)
    static let appFontNormal = UIFont(name: "AvenirNext-Medium", size: 20.0)
    static let appFontBold = UIFont(name: "AvenirNext-Bold", size: 20.0)
}

// heart icons for "like" buttons

enum Icon: String {
    case like = "❤️"
    case unlike = "🖤"
}
