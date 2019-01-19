//
//  UIViewController+Rotation.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    fileprivate func removeResizingMasks() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Constraints relative to superview
    public func addConstraintsToFillSuperview() {
        removeResizingMasks()
        if let superview = self.superview {
            _ = addConstraintsToCenterHorizontally(0)
            _ = addConstraintsToCenterVertically(0)
            _ = addConstraintsToMatchWidthOfItem(superview)
            _ = addConstraintsToMatchHeightOfItem(superview)
        }
    }
    public func addConstraintsToCenterVertically(_ padding: CGFloat = 0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview!, attribute: .centerY, multiplier: multiplier, constant: padding)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToCenterHorizontally(_ padding: CGFloat = 0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview!, attribute: .centerX, multiplier: multiplier, constant: padding)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToFillWidth(_ padding: CGFloat = 0) -> [NSLayoutConstraint] {
        removeResizingMasks()
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[self]-(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: ["padding":padding], views: ["self":self]) as [NSLayoutConstraint]
        self.superview?.addConstraints(constraints)
        return constraints
    }
    public func addConstraintsToFillHeight(_ padding: CGFloat = 0) -> [NSLayoutConstraint] {
        removeResizingMasks()
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[self]-(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: ["padding":padding], views: ["self":self]) as [NSLayoutConstraint]
        self.superview?.addConstraints(constraints)
        return constraints
    }
    public func addConstraintsToPinToTopOfSuperview(_ padding: CGFloat = 0) -> [NSLayoutConstraint] {
        removeResizingMasks()
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[self]", options: NSLayoutConstraint.FormatOptions(), metrics: ["padding":padding], views: ["self":self]) as [NSLayoutConstraint]
        self.superview?.addConstraints(constraints)
        return constraints
    }
    public func addConstraintsToPinToBottomOfSuperview(_ padding: CGFloat = 0) -> [NSLayoutConstraint] {
        removeResizingMasks()
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[self]-(padding)-|", options: NSLayoutConstraint.FormatOptions(), metrics: ["padding":padding], views: ["self":self]) as [NSLayoutConstraint]
        self.superview?.addConstraints(constraints)
        return constraints
    }
    public func addConstraintsToPinLeadingToSuperview(_ constant: CGFloat, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .leading,
                                            multiplier: multiplier, constant: constant)
        
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToPinTrailingToSuperview(_ constant: CGFloat, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .trailing,
                                            multiplier: multiplier, constant: constant)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    
    // MARK: - Constraints relative to other views
    public func addConstraintsToMatchCenterXOfItem(_ item: Any, multiplier: CGFloat = 1.0, padding: CGFloat = 0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: item, attribute: .centerX, multiplier: multiplier, constant: padding)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToMatchCenterYOfItem(_ item: Any, multiplier: CGFloat = 1.0, padding: CGFloat = 0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: multiplier, constant: padding)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToMatchHeightOfItem(_ item: Any, multiplier: CGFloat = 1.0, padding: CGFloat = 0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: item, attribute: .height, multiplier: multiplier, constant: padding)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToMatchWidthOfItem(_ item: Any, multiplier: CGFloat = 1.0, padding: CGFloat = 0) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: item, attribute: .width, multiplier: multiplier, constant: padding)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToPinTopToItem(_ item: Any, multiplier: CGFloat = 1.0, constant: CGFloat) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .top,
                                            multiplier: multiplier, constant: constant)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToPinBottomToItem(_ item: Any, multiplier: CGFloat = 1.0, constant: CGFloat) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .bottom,
                                            multiplier: multiplier, constant: constant)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToPinLeadingToItem(_ item: Any, multiplier: CGFloat = 1.0, constant: CGFloat) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .leading,
                                            multiplier: multiplier, constant: constant)
        
        self.superview?.addConstraint(constraint)
        return constraint
    }
    public func addConstraintsToPinTrailingToItem(_ item: Any, multiplier: CGFloat = 1.0, constant: CGFloat) -> NSLayoutConstraint {
        removeResizingMasks()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: item,
                                            attribute: .trailing,
                                            multiplier: multiplier, constant: constant)
        self.superview?.addConstraint(constraint)
        return constraint
    }
    
    public func addConstraintsToPositionAboveView(_ view: UIView, spacing: CGFloat = 0) -> [NSLayoutConstraint] {
        removeResizingMasks()
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[self]-(spacing)-[view]", options: NSLayoutConstraint.FormatOptions(), metrics: ["spacing":spacing], views: ["self":self, "view":view]) as [NSLayoutConstraint]
        self.superview?.addConstraints(constraint)
        return constraint
    }
    public func addConstraintsToPositionBelowView(_ view: UIView, spacing: CGFloat = 0) -> [NSLayoutConstraint] {
        removeResizingMasks()
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(spacing)-[self]", options: NSLayoutConstraint.FormatOptions(), metrics: ["spacing":spacing], views: ["self":self, "view":view]) as [NSLayoutConstraint]
        self.superview?.addConstraints(constraints)
        return constraints
    }
    
    public func activateAllConstraints() {
        NSLayoutConstraint.activate(self.constraints)
    }
    public func deactivateAllConstraints() {
        NSLayoutConstraint.deactivate(self.constraints)
    }
    public func constraintsForAttributes(_ attribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
        var attributeConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
        for constraint in self.constraints as [NSLayoutConstraint] {
            if constraint.firstAttribute == attribute {
                attributeConstraints.append(constraint)
            }
        }
        return attributeConstraints
    }
    
}

public extension UIView {
    /// Returns a boolean indicating whether the view's width is currently in regular mode
    /// On iOS 7 this will return true when the device is an iPad and false on iPhone
    public func isHorizontalSizeClassRegularWidth () -> Bool {
        //        if #available(iOS 8.0, *) {
        //            return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Regular || self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Unspecified
        //        } else {
        //            return isIPad()
        //        }
        return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular || self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.unspecified
    }
}

public extension UIView {
    public func setBorder(_ color: UIColor = UIColor.black, borderWidth: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
}

public extension UIView {
    public func addGradientColorWithColors(_ colors: [UIColor]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        for col in colors as [UIColor] {
            gradient.colors?.append(col.cgColor)
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

public extension UIView {
    public func removeAllSubviews() {
        for subview in self.subviews as [UIView] {
            subview.removeFromSuperview()
        }
    }
    public func removeSubview(_ subview: UIView) {
        for sub in self.subviews as [UIView] {
            if sub == subview {
                sub.removeFromSuperview()
            }
        }
    }
}

public extension UIView {
    public func addBlurredBackground(_ effectStyle: UIBlurEffect.Style, autoLayout: Bool = true, alpha: CGFloat = 1.0) {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            effectStyle))
        blur.tag = 199
        self.viewWithTag(199)?.removeFromSuperview()
        self.insertSubview(blur, at: 0)
        if autoLayout {
            blur.addConstraintsToFillSuperview()
        } else {
            blur.frame = self.bounds
        }
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
    }
}
public extension UIView {
    public class func loadFromNibNamed(_ nibNamed: String, bundle: Bundle? = Bundle(for: classForCoder()), frame: CGRect? = CGRect.zero) -> UIView? {
        let nibView = UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
        if frame != nil {
            nibView?.frame = frame!
            nibView?.translatesAutoresizingMaskIntoConstraints = true
        }
        return nibView
    }
}

public extension UIView {
    public func addBottomSeparatorLine(_ color: UIColor = UIColor.lightGray, height: CGFloat = 1, multiplier: CGFloat = 1.0, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        self.viewWithTag(99)?.removeFromSuperview()
        let bottomSeparatorLineView = UIView()
        bottomSeparatorLineView.tag = 99
        bottomSeparatorLineView.backgroundColor = color
        self.addSubview(bottomSeparatorLineView)
        _ = bottomSeparatorLineView.addConstraintsToMatchWidthOfItem(self)
        _ = bottomSeparatorLineView.addConstraintsToPinLeadingToItem(self, constant: xOffset)
        _ = bottomSeparatorLineView.addConstraintsToPinBottomToItem(self, constant: yOffset)
        self.addConstraint(NSLayoutConstraint(item: bottomSeparatorLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: height))
    }
    public func addTopSeparatorLine(_ color: UIColor = UIColor.lightGray, height: CGFloat = 1, multiplier: CGFloat = 1.0, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        self.viewWithTag(98)?.removeFromSuperview()
        let topSeparatorLineView = UIView()
        topSeparatorLineView.tag = 98
        topSeparatorLineView.backgroundColor = color
        self.addSubview(topSeparatorLineView)
        _ = topSeparatorLineView.addConstraintsToMatchWidthOfItem(self)
        _ = topSeparatorLineView.addConstraintsToPinLeadingToItem(self, constant: xOffset)
        _ = topSeparatorLineView.addConstraintsToPinTopToItem(self, constant: yOffset)
        self.addConstraint(NSLayoutConstraint(item: topSeparatorLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: height))
    }
    public func addLeftSeparatorLine(_ color: UIColor = UIColor.lightGray, width: CGFloat = 1, multiplier: CGFloat = 1.0, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        self.viewWithTag(98)?.removeFromSuperview()
        let topSeparatorLineView = UIView()
        topSeparatorLineView.tag = 98
        topSeparatorLineView.backgroundColor = color
        self.addSubview(topSeparatorLineView)
        _ = topSeparatorLineView.addConstraintsToMatchHeightOfItem(self)
        _ = topSeparatorLineView.addConstraintsToPinLeadingToItem(self, constant: xOffset)
        _ = topSeparatorLineView.addConstraintsToPinTopToItem(self, constant: yOffset)
        self.addConstraint(NSLayoutConstraint(item: topSeparatorLineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: width))
    }
    public func addRightSeparatorLine(_ color: UIColor = UIColor.lightGray, width: CGFloat = 1, multiplier: CGFloat = 1.0, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        self.viewWithTag(98)?.removeFromSuperview()
        let topSeparatorLineView = UIView()
        topSeparatorLineView.tag = 98
        topSeparatorLineView.backgroundColor = color
        self.addSubview(topSeparatorLineView)
        _ = topSeparatorLineView.addConstraintsToMatchHeightOfItem(self)
        _ = topSeparatorLineView.addConstraintsToPinTrailingToItem(self, constant: xOffset)
        _ = topSeparatorLineView.addConstraintsToPinTopToItem(self, constant: yOffset)
        self.addConstraint(NSLayoutConstraint(item: topSeparatorLineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: width))
    }
}

public extension UIView {
    public func fadeTransition(_ duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        self.layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.fade))
    }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromCATransitionType(_ input: CATransitionType) -> String {
    return input.rawValue
}
