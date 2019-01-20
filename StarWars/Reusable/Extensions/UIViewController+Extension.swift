//
//  UIViewController+Extension.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
extension UIViewController {
    open func addChildViewController(_ childController: UIViewController, containerView: UIView, autolayoutActive: Bool = true) {
        childController.willMove(toParent: self)
        containerView.addSubview(childController.view)
        if autolayoutActive {
            childController.view.addConstraintsToFillSuperview()
        } else {
            childController.view.frame = containerView.bounds
        }
        childController.view.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        addChild(childController)
        childController.didMove(toParent: self)
    }
    open func isPushed() -> Bool {
        if self.navigationController != nil {
            return (self.navigationController!.viewControllers[0] != self) && (self.navigationController!.viewControllers.contains(self) || self.navigationController!.topViewController == self)
        }
        return false
    }
    
    open func isModal() -> Bool {
        if (self.presentingViewController) != nil {
            return true
        }
        if self.presentingViewController?.presentedViewController == self {
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        if (self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self)) != nil {
            return true
        }
        return false
    }
    open func isVisible() -> Bool {
        return self.isViewLoaded && (self.view.window != nil)
    }
    open var isTopViewController: Bool {
        if let topController = topViewController() {
            return topController == self
        }
        return false
    }
    @objc open func forceViewReload() {
        
    }
    @objc open func loadSubviews() {
        
    }
    @objc open func setupSubviewsLayout() {
        
    }
    @objc open func applySubviewsAppearance() {
        
    }
    
}
