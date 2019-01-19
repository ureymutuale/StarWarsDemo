//
//  SWAppColor.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

public let defaultBlueColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)

class SWAppColor: NSObject {
    
    static let themeMainColor: UIColor = UIColor(hex: "#B31F24") //Theme Main Color
    static let themeDarkColor: UIColor = UIColor.black
    static let themeLowDarkColor: UIColor = UIColor.darkText
    static let themeMediumColor: UIColor = UIColor.gray
    static let themeLightColor: UIColor = UIColor.white
    static let themeLowLightColor: UIColor = UIColor.lightGray
    static let defaultViewBackgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    
    // MARK: DefaultScreen
    struct DefaultScreen {
        struct Navigationbar {
            static var barColor: UIColor {
                return themeMainColor
            }
            static var borderColor: UIColor {
                return themeLowLightColor
            }
            static var titleColor: UIColor {
                return themeLightColor
            }
            static var itemTintColor: UIColor {
                return themeLightColor
            }
            static var highlightedItemTintColor: UIColor {
                return themeMediumColor
            }
        }
        static var backgroundColor: UIColor {
            return defaultViewBackgroundColor
        }
        static var statusBarStyle: UIStatusBarStyle {
            return UIStatusBarStyle.default
        }
    }
}
