//
//  Reusables.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
import QuartzCore


public func delay(seconds: Double, completion: @escaping ()->Void) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}
public func isPortrait() -> Bool {
    return UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width || UIDevice.current.orientation.isPortrait
}
public func isLandscape() -> Bool {
    return UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height || UIDevice.current.orientation.isLandscape
}

public func topViewController() -> UIViewController? {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        if let navigationController = topController as? UINavigationController, let visibleController = navigationController.visibleViewController {
            topController = visibleController
        }
        if let tabController = topController as? UITabBarController, let selected = tabController.selectedViewController {
            topController = selected
        }
        /*if let presented = topController.presentedViewController {
         topController = presented
         }*/
        //print("TOP VC: \(topController)")
        return topController
    }
    return nil
}
public func isIPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
}

public extension  URL {
    public var isValidWebURL: Bool {
        /*let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
         let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
         let urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
         return predicate.evaluateWithObject(self.absoluteString)*/
        let request = URLRequest(url: self)
        return NSURLConnection.canHandle(request)
    }
}


public func radians(_ degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(CGFloat.pi/180)
}
