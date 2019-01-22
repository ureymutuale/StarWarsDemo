//
//  SWLoadingView.swift
//  StarWars
//
//  Created by UreyMt on 1/21/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWLoadingView: UIView {

    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var loadingLabel: UILabel!
    @IBOutlet fileprivate weak var loadingImageView: UIImageView!
    
    fileprivate(set) var appWindow: UIWindow?
    
    var loadingTitle: String? {
        didSet {
            self.applySubviewsAppearance()
        }
    }
    var loadingTitleFont: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            self.loadingLabel.font = loadingTitleFont
            self.applySubviewsAppearance()
        }
    }
    
    // MARK: + Initialization  methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadSubviews()
    }
    
    // MARK: + Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: + View Setup methods
    fileprivate func loadSubviews() {
        if let appDelegate = UIApplication.shared.delegate! as? AppDelegate {
            if let window = appDelegate.window {
                self.appWindow = window
            }
        }
        
        //Images
        let spriteName = "loading2"
        let animationDuration = 0.8
        var spriteArray = [UIImage]()
        for i in 0...22 {
            if let image = UIImage(named: "\(spriteName)\(i).gif") {
                spriteArray.append(image)//.imageWithColor(SWAppColor.themeSecondaryColor))
            }
        }
        self.loadingImageView.animationImages = spriteArray
        self.loadingImageView.animationDuration = animationDuration
        
        // Motion effects
        let horizontalMotionEffect: UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffect.EffectType.tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -10
        horizontalMotionEffect.maximumRelativeValue = 10
        
        let verticalMotionEffect: UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffect.EffectType.tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -10
        verticalMotionEffect.maximumRelativeValue = 10
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        self.containerView.addMotionEffect(group)
    }
    fileprivate func applySubviewsAppearance() {
        
    }
    
    // MARK: + View Setup methods
    fileprivate func addConstraints(_ parentView: Any) {
        _ = self.addConstraintsToMatchCenterYOfItem(parentView)
        _ = self.addConstraintsToMatchCenterXOfItem(parentView)
        _ = self.addConstraintsToMatchWidthOfItem(parentView)
        _ = self.addConstraintsToMatchHeightOfItem(parentView)
    }
    
    // MARK: + Private methods
    
    // MARK: + Action methods
    
    // MARK: + Public methods
    func showInView(_ parentView: UIView?) {
        self.loadingImageView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let parentView = parentView {
            self.layer.opacity = 0.5
            parentView.addSubview(self)
            self.addConstraints(parentView)
        } else if let window = self.appWindow {
            //window.windowLevel = UIWindowLevelAlert
            self.layer.opacity = 0.5
            window.addSubview(self)
            self.addConstraints(window)
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.layer.opacity = 1.0
            //            self.appWindow?.layoutIfNeeded()
            //            parentView?.layoutIfNeeded()
        }, completion: { _  in
            
        })
    }
    func dismissFromView(_ parentView: UIView?) {
        if let window = self.appWindow {
            window.windowLevel = UIWindow.Level.normal
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            self.layer.opacity = 0.0
            //            self.appWindow?.layoutIfNeeded()
            //            parentView?.layoutIfNeeded()
        }, completion: { _  in
            self.removeFromSuperview()
            self.loadingImageView.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }

}
