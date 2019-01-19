//
//  SWApp.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

public class SWApp: NSObject {
    
    // MARK: - App Details
    // MARK: + App bundleID
    public class var bundleID: String {
        var bundleID = "App Bundle ID"
        if let actualBundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String {
            bundleID = actualBundleID
        }
        return "\(bundleID)"
    }
    // MARK: + App name
    public class var name: String {
        var name = "App Name"
        if let actualName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            name = actualName
        }
        return "\(name)"
    }
    // MARK: + App versionNumber
    public class var versionNumber: String {
        var version = "0"
        if let actualversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version = actualversion
        }
        return "\(version)"
    }
    // MARK: + App buildNumber
    public class var buildNumber: String {
        var build = "0"
        if let actualBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            build = actualBuild
        }
        return "\(build)"
    }
    
    // MARK: + App Icon
    public class var appIcon: UIImage? {
        var image: UIImage?
        if let bundleIcons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any], let iconDict = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any], let appIconNames = iconDict["CFBundleIconFiles"] as? [String] {
            for name in appIconNames {
                image = UIImage(named: name)
                if (name as NSString).range(of: "@3x").location != NSNotFound {
                    image = UIImage(named: name)
                    break
                }
            }
        }
        return image
    }
    
    public class var watermarkImage: UIImage? {
        return nil
    }
    public class var placeLoaderImage: UIImage? {
        return nil
    }
    public class var imageViewBackgroundColor: UIColor {
        return UIColor.clear
    }
    
    // MARK: - Fonts
    // MARK: + fontSizeScale
    public static var fontSizeScale: CGFloat {
        var scale: CGFloat = UIScreen.main.scale as CGFloat
        return scale
    }
    
    public static var isInTestFlight: Bool {
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }
    public static var isRunningOnSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
        return true
        #else
        return false
        #endif
    }
}
