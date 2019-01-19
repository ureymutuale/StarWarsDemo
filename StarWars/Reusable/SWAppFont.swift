//
//  SWAppFont.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

private enum SWAppFontType: String {
    case light = "HelveticaNeue-Light"
    case regular = "HelveticaNeue"
    case semiBold = "HelveticaNeue-Medium"
    case bold = "HelveticaNeue-Bold"
}
class SWAppFont: NSObject {
    
    static var scale: CGFloat {
        return SWApp.fontSizeScale
    }
    static var ratio: CGFloat {
        if isLandscape() { //Rotated
            return (UIScreen.main.bounds.size.height/UIScreen.main.bounds.size.width)
        } else {
            return (UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height)
        }
    }
    
    // MARK: general font
    private class func fontWithType(type fontType: SWAppFontType, size: CGFloat) -> UIFont {
        /*for family: String in UIFont.familyNames {
            NSLog("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                NSLog("== \(names)")
            }
        }*/
        let font = UIFont(name: fontType.rawValue, size: size)!
        return font
    }
    private class func dynamicFont(type fontType: SWAppFontType, style fontStyle: String) -> UIFont {
        let sytemDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle(rawValue: fontStyle))
        let size = sytemDynamicFontDescriptor.pointSize
        let font = UIFont(name: fontType.rawValue, size: size)
        return font!
    }
    
    // MARK: DefaultScreen
    struct DefaultScreen {
        struct Navigationbar {
            static var titleFont: UIFont {
                var fontSize: CGFloat = 28
                let fontMultiplier = (scale > 1) ? (1 - (ratio/(scale))) : 1
                fontSize = fontMultiplier * fontSize
                return SWAppFont.fontWithType(type: .semiBold, size: fontSize)
            }
            static var itemTextFont: UIFont {
                var fontSize: CGFloat = 28
                let fontMultiplier = (scale > 1) ? (1 - (ratio/(scale))) : 1
                fontSize = fontMultiplier * fontSize
                return SWAppFont.fontWithType(type: .regular, size: fontSize)
            }
        }
    }
}
