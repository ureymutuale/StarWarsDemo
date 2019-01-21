//
//  SWViewController.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWViewController: UIViewController {

    open var keyboardFrame: CGRect?
    open var isKeyboardVisible: Bool = false
    
    public convenience init(fromNib: Bool = true) {
        if fromNib {
            self.init(nibName: "SWViewController", bundle: Bundle(for: SWViewController.classForCoder()))
        } else {
            self.init(nibName: nil, bundle: nil)
        }
        self.view.backgroundColor = UIColor.black
    }
    
    // MARK: + Overriden methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge()
        }
        self.loadSubviews()
        self.applySubviewsAppearance()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //NSLog("\(NSStringFromClass(self.classForCoder)) viewWillAppear")
        self.applySubviewsAppearance()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //NSLog("\(NSStringFromClass(self.classForCoder)) viewDidAppear")
        self.forceViewControllerOrientation()
        self.applySubviewsAppearance()
        self.setNeedsStatusBarAppearanceUpdate()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //NSLog("\(NSStringFromClass(self.classForCoder)) viewWillDisappear")
        self.applySubviewsAppearance()
        self.setNeedsStatusBarAppearanceUpdate()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.view.endEditing(true)
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //NSLog("\(NSStringFromClass(self.classForCoder)) viewDidDisappear")
        self.applySubviewsAppearance()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupSubviewsLayout()
        self.applySubviewsAppearance()
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    public override var prefersStatusBarHidden: Bool {
        return false
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //NSLog("\(NSStringFromClass(self.classForCoder)) didReceiveMemoryWarning")
    }
    
    // MARK: + View Setup methods
    public override func loadSubviews() {
        super.loadSubviews()
    }
    public override func applySubviewsAppearance() {
        super.applySubviewsAppearance()
        self.forceViewControllerOrientation()
    }
    public override func forceViewReload() {
        super.forceViewReload()
        self.forceViewControllerOrientation()
    }
    
    // MARK: + Action methods
    @objc public func handleDismissTap(_ gesture: UIGestureRecognizer) {
        
    }
    public func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: + Orientation methods
    override public var shouldAutorotate: Bool {
        return true
    }
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if isIPad() {
            return UIInterfaceOrientationMask.landscape
        }
        return UIInterfaceOrientationMask.portrait
    }
    public func forceViewControllerOrientation() {
        if isIPad() && !isLandscape() {
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }
    
    // MARK: + UIKeyboard notifications methods
    @objc open func keyboardWillChangeFrame(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            self.keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            if let userInfo = notification.userInfo {
                let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
                UIView.animate(withDuration: duration, animations: {
                    if endFrame!.origin.y >= self.view.frame.size.height { //hidden
                        self.isKeyboardVisible = false
                    } else {//shown
                        self.isKeyboardVisible = true
                    }
                })
            }
        }
    }

}
