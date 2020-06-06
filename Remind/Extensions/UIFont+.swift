//
//  UIFont+.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum SFProTextStyle: String {
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case heavy = "Heavy"
        case heavyItalic = "HeavyItalic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case regular = "Regular"
        case regularItalic = "RegularItalic"
        case semibold = "Semibold"
        case semiboldItalic = "SemiboldItalic"
    }
    
    class func sfProText(size: CGFloat, style: SFProTextStyle = .regular) -> UIFont {
        let name = "SFProText-" + style.rawValue
        if let font = UIFont(name: name, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    class func signupTextInputFonts() -> (label: UIFont, textField: UIFont) {
        return (sfProText(size: 16, style: .light),
                sfProText(size: 18, style: .light))
    }
    
    class func signinTextInputFonts() -> (label: UIFont, textField: UIFont) {
        return signupTextInputFonts()
    }
    
}
