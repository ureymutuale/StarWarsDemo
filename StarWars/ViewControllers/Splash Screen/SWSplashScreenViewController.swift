//
//  SWSplashScreenViewController.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWSplashScreenViewController: SWViewController {
    
    var destination: UIViewController?
    var launchBgImageView: UIImageView?
    var launchLogoImageView: UIImageView?
    var launchLoadingActivity: UIActivityIndicatorView?
    
    // MARK: + Initialization  methods
    convenience init(fromNib: Bool = true) {
        if fromNib {
            self.init(nibName: "SWSplashScreenViewController", bundle: nil)
        } else {
            self.init(nibName: nil, bundle: nil)
        }
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    // MARK: + Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.updateLaunchImageView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SWAppColor.DefaultScreen.statusBarStyle
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSLog("\(NSStringFromClass(self.classForCoder)) didReceiveMemoryWarning")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedLaunch" && (self.launchBgImageView == nil || self.launchLogoImageView == nil) {
            var destinationVC = segue.destination
            if let nav = destinationVC as? UINavigationController, let rootVC = nav.viewControllers.first {
                destinationVC = rootVC
            }
            self.destination = destinationVC
            for subview in destinationVC.view.subviews {
                if subview.tag == 99, subview.isKind(of: UIImageView.classForCoder()) {
                    self.launchBgImageView = subview as? UIImageView
                } else if subview.tag == 98, subview.isKind(of: UIImageView.classForCoder()) {
                    self.launchLogoImageView = subview as? UIImageView
                } else if subview.tag == 97, subview.isKind(of: UIActivityIndicatorView.classForCoder()) {
                    self.launchLoadingActivity = subview as? UIActivityIndicatorView
                }
            }
            
            self.animateEntry()
            //self.animateExit()
        }
    }
    
    // MARK: + View Setup methods
    override func loadSubviews() {
        super.loadSubviews()
    }
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
    }
    override func applySubviewsAppearance() {
        super.applySubviewsAppearance()
        self.view.backgroundColor = SWAppColor.DefaultScreen.backgroundColor
        self.navigationController?.setupNavigationControllerWithBarColor(barColor: SWAppColor.DefaultScreen.Navigationbar.barColor, tintColor: SWAppColor.DefaultScreen.Navigationbar.itemTintColor, titleColor: SWAppColor.DefaultScreen.Navigationbar.titleColor, titleFont: SWAppFont.DefaultScreen.Navigationbar.titleFont, hidden: true)
        self.navigationController?.setBottomBorderColor(SWAppColor.DefaultScreen.Navigationbar.borderColor, height: 0.2)
    }
    override func forceViewReload() {
        super.forceViewReload()
    }
    
    // MARK: + Private methods
    fileprivate func animateEntry() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.launchLogoImageView?.center = self.randomCenter()
            UIView.animate(withDuration: 1.0, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.launchLogoImageView?.isHidden = false
                self.launchLogoImageView?.center = self.view.center
            }, completion: { (done) in
                UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    SWNavigationCoordinator.default.setupAppNavigation()
                    self.launchLoadingActivity?.stopAnimating()
                }, completion: nil)
            })
        })
    }
    fileprivate func animateExit() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.launchLogoImageView?.isHidden = false
            //self.launchLogoImageView?.center = self.view.center
            UIView.animate(withDuration: 1.0, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.launchLogoImageView?.center = self.randomCenter()
            }, completion: { (done) in
                UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    SWNavigationCoordinator.default.setupAppNavigation()
                    self.launchLoadingActivity?.stopAnimating()
                }, completion: nil)
            })
        })
    }
    fileprivate func randomCenter() -> CGPoint {
        var point = CGPoint(x: 0, y: 0)
        let position = Int.random(in: 0 ... 3)
        switch position {
        case 0: //Top
            point = CGPoint(x: self.view.center.x, y: 0 - (self.view.frame.size.height * 0.5))
        case 1: //Right
            point = CGPoint(x: self.view.frame.size.width * 1.5, y: self.view.center.y)
        case 2: //Bottom
            point = CGPoint(x: self.view.center.x, y: self.view.frame.size.height * 1.5)
        case 3: //Left
            point = CGPoint(x: -self.view.frame.size.width * 1.5, y: self.view.center.y)
        default:
            break
        }
        return point
    }
    
    // MARK: + Action methods
    @IBAction func dismissCurrentViewController(_ sender: Any) {
        if self.isPushed() {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: + UIKeyboard notifications methods
}
