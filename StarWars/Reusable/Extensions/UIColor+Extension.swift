//
//  UIColor+Extension.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
import QuartzCore

public extension UIColor {
    /// Returns the inverse color
    public var inverseColor: UIColor {
        var r: CGFloat = 0.0; var g: CGFloat = 0.0; var b: CGFloat = 0.0; var a: CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return self
    }
    
    public convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    public convenience init(hex: String, alpha: Float = 1) {
        var hexString = hex
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            hexString = String(hexString[index...])
        }
        guard let hexVal = Int(hexString, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        switch hexString.count {
        case 3:
            self.init(red: CGFloat( ((hexVal & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                      green: CGFloat( ((hexVal & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                      blue: CGFloat( ((hexVal & 0x00F) >> 0).duplicate4bits() ) / 255.0,
                      alpha: CGFloat(alpha))
        case 6:
            self.init(red: CGFloat( (hexVal & 0xFF0000) >> 16 ) / 255.0,
                      green: CGFloat( (hexVal & 0x00FF00) >> 8 ) / 255.0,
                      blue: CGFloat( (hexVal & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
        default:
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    public func colorWithAlpha(_ alpha: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, originalAlpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &originalAlpha) {
            let newColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            return newColor
        }
        return self
    }
    public static func randomColor() -> UIColor {
        let r = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let g = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let b = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}

extension UIColor {
    func lighterBy(_ percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjustBy(abs(percentage) )
    }
    func darkerBy(_ percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjustBy( -1 * abs(percentage) )
    }
    func adjustBy(_ percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat=0, green: CGFloat=0, blue: CGFloat=0, alpha: CGFloat=0
        if(self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return self
        }
    }
}
