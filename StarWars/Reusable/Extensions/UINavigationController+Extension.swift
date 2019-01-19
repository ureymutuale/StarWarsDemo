//
//  UINavigationController+Extension.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

public extension UINavigationController {
    public func setupNavigationControllerWithBarColor(barColor: UIColor, tintColor: UIColor = UIColor.black, titleColor: UIColor = UIColor.black, titleFont: UIFont = UIFont.systemFont(ofSize: 17), hidden: Bool = false, translucent: Bool = false, transparent: Bool = false) {
        self.isNavigationBarHidden = hidden
        
        let font: UIFont = titleFont
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:titleColor, NSAttributedString.Key.font:font]
        if transparent {
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
            self.view.backgroundColor = UIColor.clear
            self.navigationBar.tintColor = tintColor
        } else {
            self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationBar.shadowImage = nil
            self.navigationBar.isTranslucent = translucent
            self.navigationBar.barStyle = UIBarStyle.black
            self.navigationBar.barTintColor = barColor
            self.navigationBar.tintColor = tintColor
        }
    }
    public func setBottomBorderColor(_ color: UIColor, height: CGFloat = 0.7) {
        let bottomBorderRect = CGRect(x: 0, y: self.navigationBar.frame.size.height, width: self.navigationBar.frame.size.width, height: height)
        let bottomBorder = UIView(frame: bottomBorderRect)
        bottomBorder.backgroundColor = color
        bottomBorder.tag = 999
        if let previousBorder = self.navigationBar.viewWithTag(999) {
            previousBorder.removeFromSuperview()
        }
        self.navigationBar.addSubview(bottomBorder)
    }
    public class func barButtonItemWithImage(_ image: UIImage?, color: UIColor? = nil, selectedImage: UIImage? = nil, selectedColor: UIColor? = nil, size: CGSize? = nil, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: UIButton.ButtonType.system)
        var buttonSize = CGSize(width: 40, height: 40)
        if let size = size {
            buttonSize = CGSize(width: size.width, height: size.height)
        }
        if #available(iOS 11.0, *) {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.frame = CGRect(origin: CGPoint(), size: buttonSize)
            button.layoutIfNeeded()
        } else {
            button.frame = CGRect(origin: CGPoint(), size: buttonSize)
        }
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(image, for: UIControl.State())
        button.setImage(image, for: UIControl.State.highlighted)
        if selectedImage != nil {
            button.setImage(selectedImage, for: UIControl.State.highlighted)
        }
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        if color != nil {
            button.tintColor = color
            button.setImageTintColor(color!, forState: UIControl.State())
            button.setImageTintColor(color!, forState: UIControl.State.highlighted)
        }
        if selectedColor != nil {
            button.setImageTintColor(selectedColor!, forState: UIControl.State.highlighted)
        }
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        if isIPad() {
            button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        //button.setBorder(UIColor.redColor(), borderWidth: 1.0)
        return UIBarButtonItem(customView: button)
    }
}
