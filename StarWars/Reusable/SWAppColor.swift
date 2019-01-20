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
    
    static let themeMainColor: UIColor = UIColor(hex: "#2F3131") //Theme Main Color
    static let themeSecondaryColor: UIColor = UIColor(hex: "#FEE63D") //Theme Main Color
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
                return defaultViewBackgroundColor
            }
            static var borderColor: UIColor {
                return themeSecondaryColor
            }
            static var titleColor: UIColor {
                return themeMainColor
            }
            static var itemTintColor: UIColor {
                return themeMainColor
            }
            static var highlightedItemTintColor: UIColor {
                return themeSecondaryColor
            }
        }
        static var backgroundColor: UIColor {
            return themeLightColor
        }
        static var statusBarStyle: UIStatusBarStyle {
            return UIStatusBarStyle.default
        }
    }
    
    // MARK:+ FilmsScreen
    struct FilmsScreen {
        struct Navigationbar {
            static var barColor: UIColor {
                return defaultViewBackgroundColor
            }
            static var borderColor: UIColor {
                return themeSecondaryColor
            }
            static var titleColor: UIColor {
                return themeMainColor
            }
            static var itemTintColor: UIColor {
                return themeMainColor
            }
            static var highlightedItemTintColor: UIColor {
                return themeSecondaryColor
            }
        }
        static var backgroundColor: UIColor {
            return themeLightColor
        }
        static var refreshControlTintColor: UIColor {
            return themeMainColor
        }
        struct FilmItemCell {
            static var backgroundColor: UIColor {
                return themeLightColor
            }
            static var selectedBackgroundColor: UIColor {
                return themeMainColor
            }
            static var borderColor: UIColor {
                return UIColor.clear
            }
            static var selectedBorderColor: UIColor {
                return themeSecondaryColor
            }
            static var titleTextColor: UIColor {
                return themeDarkColor
            }
            static var selectedTitleTextColor: UIColor {
                return themeLightColor
            }
            static var detailsTextColor: UIColor {
                return themeLowLightColor
            }
            static var selectedDetailsTextColor: UIColor {
                return themeLightColor
            }
        }
        static var statusBarStyle: UIStatusBarStyle {
            return UIStatusBarStyle.default
        }
    }
    
    // MARK:+ FilmDetailsScreen
    struct FilmDetailsScreen {
        struct Navigationbar {
            static var barColor: UIColor {
                return defaultViewBackgroundColor
            }
            static var borderColor: UIColor {
                return themeSecondaryColor
            }
            static var titleColor: UIColor {
                return themeMainColor
            }
            static var itemTintColor: UIColor {
                return themeMainColor
            }
            static var highlightedItemTintColor: UIColor {
                return themeSecondaryColor
            }
        }
        static var backgroundColor: UIColor {
            return themeLightColor
        }
        static var statusBarStyle: UIStatusBarStyle {
            return UIStatusBarStyle.default
        }
    }
}
