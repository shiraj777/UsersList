//
//  Constants.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

enum Images {
    static let placeholder = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo = UIImage(named:  "empty-state-logo")
    static let share = UIImage(systemName:  "square.and.arrow.up")
    static let totalLicksIcon = UIImage(named:  "pay_icon")
}


let fontName          = "opensanshebrew"

enum DUFontName: String {
    case extrabold    = "-extrabold"
    case bold         = "-bold"
    case regular      = "-regular"
    case lite         = "-light"
}


enum DUColors {
    static let blue = #colorLiteral(red: 0.368627451, green: 0.4823529412, blue: 0.9254901961, alpha: 1)
    static let bolyColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
}
