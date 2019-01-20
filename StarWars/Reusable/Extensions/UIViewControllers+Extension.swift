//
//  UIViewControllers+Extension.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

extension UISplitViewController {
    open override var shouldAutorotate: Bool {
        if let tab = self.viewControllers[0] as? UITabBarController {
            return tab.shouldAutorotate
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            return navigation.shouldAutorotate
        }
        return true
    }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let tab = self.viewControllers[0] as? UITabBarController {
            return tab.supportedInterfaceOrientations
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            return navigation.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.all
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let tab = self.viewControllers[0] as? UITabBarController {
            return tab.preferredStatusBarStyle
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            return navigation.preferredStatusBarStyle
        }
        return UIStatusBarStyle.default
    }
    open override var childForStatusBarStyle: UIViewController? {
        return self.viewControllers[0]
    }
    open override var prefersStatusBarHidden: Bool {
        if let tab = self.viewControllers[0] as? UITabBarController {
            return tab.prefersStatusBarHidden
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            return navigation.prefersStatusBarHidden
        }
        return false
    }
    open override var childForStatusBarHidden: UIViewController? {
        return self.viewControllers[0]
    }
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        if let tab = self.viewControllers[0] as? UITabBarController {
            return tab.preferredStatusBarUpdateAnimation
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            return navigation.preferredStatusBarUpdateAnimation
        }
        return UIStatusBarAnimation.slide
    }
    
    open override func forceViewReload() {
        if let tab = self.viewControllers[0] as? UITabBarController {
            tab.forceViewReload()
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            navigation.forceViewReload()
        }
    }
    open override func setupSubviewsLayout() {
        if let tab = self.viewControllers[0] as? UITabBarController {
            tab.setupSubviewsLayout()
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            navigation.setupSubviewsLayout()
        }
    }
    open override func applySubviewsAppearance() {
        if let tab = self.viewControllers[0] as? UITabBarController {
            tab.applySubviewsAppearance()
        } else if let navigation = self.viewControllers[0] as? UINavigationController {
            navigation.applySubviewsAppearance()
        }
    }
}

extension UINavigationController {
    open override var shouldAutorotate: Bool {
        if let viewController = visibleViewController {
            return viewController.shouldAutorotate
        }
        return true
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let viewController = visibleViewController {
            return viewController.preferredStatusBarStyle
        }
        return UIStatusBarStyle.default
    }
    open override var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }
    open override var prefersStatusBarHidden: Bool {
        if let viewController = visibleViewController {
            return viewController.prefersStatusBarHidden
        }
        return false
    }
    open override var childForStatusBarHidden: UIViewController? {
        return self.visibleViewController
    }
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        if let viewController = visibleViewController {
            return viewController.preferredStatusBarUpdateAnimation
        }
        return UIStatusBarAnimation.slide
    }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let viewController = visibleViewController {
            if viewController.isKind(of: UIAlertController.self) {
                return UIInterfaceOrientationMask.all
            }
            return viewController.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.all
    }
    
    open override func forceViewReload() {
        if let viewController = visibleViewController {
            viewController.forceViewReload()
        }
    }
    open override func setupSubviewsLayout() {
        if let viewController = visibleViewController {
            viewController.setupSubviewsLayout()
        }
    }
    open override func applySubviewsAppearance() {
        if let viewController = visibleViewController {
            viewController.applySubviewsAppearance()
        }
    }
}

extension UITabBarController {
    open override var shouldAutorotate: Bool {
        if let viewController = selectedViewController {
            return viewController.shouldAutorotate
        }
        return true
    }
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let viewController = selectedViewController {
            return viewController.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.all
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let viewController = self.selectedViewController {
            return viewController.preferredStatusBarStyle
        }
        return UIStatusBarStyle.default
    }
    open override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }
    open override var prefersStatusBarHidden: Bool {
        if let viewController = self.selectedViewController {
            return viewController.prefersStatusBarHidden
        }
        return false
    }
    open override var childForStatusBarHidden: UIViewController? {
        return self.selectedViewController
    }
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        if let viewController = selectedViewController {
            return viewController.preferredStatusBarUpdateAnimation
        }
        return UIStatusBarAnimation.slide
    }
    
    open override func forceViewReload() {
        if let viewController = selectedViewController {
            viewController.forceViewReload()
        }
    }
    open override func setupSubviewsLayout() {
        if let viewController = selectedViewController {
            viewController.setupSubviewsLayout()
        }
    }
    open override func applySubviewsAppearance() {
        if let viewController = selectedViewController {
            viewController.applySubviewsAppearance()
        }
    }
}
