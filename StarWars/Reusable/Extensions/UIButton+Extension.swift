//
//  UIButton+Extension.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

extension UIButton {
    override open var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right, height: superSize.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)
    }
    
    public func setImageTintColor(_ color: UIColor, forState state: UIControl.State) {
        if let bImage = self.image(for: state) {
            self.setImage(bImage.imageWithColor(color), for: state)
        }
    }
    public func setBackgroundImageTintColor(_ color: UIColor, forState state: UIControl.State) {
        if let bImage = self.backgroundImage(for: state) {
            self.setBackgroundImage(bImage.imageWithColor(color), for: state)
        }
    }
    public func centerImageView() {
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.imageView?.center = self.center
        self.imageView?.frame.size = CGSize(width: self.bounds.width/3, height: self.bounds.height/4)
        //        self.imageView?.setBorder(UIColor.blueColor(), borderWidth: 0.5)
        //        self.setBorder(UIColor.whiteColor(), borderWidth: 0.5)
    }
}
