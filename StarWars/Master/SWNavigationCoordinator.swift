//
//  SWNavigationCoordinator.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
import SafariServices

class SWNavigationCoordinator: NSObject {
    static let `default`: SWNavigationCoordinator = {
        let instance = SWNavigationCoordinator()
        return instance
    }()
    
    fileprivate(set) weak var appDelegate: AppDelegate?
    fileprivate(set) var mainStoryboard: UIStoryboard!
    fileprivate(set) var mainNavigationController: SWNavigationController?
    fileprivate(set) var mainSplitViewController: SWSplitViewController?
    
    override init() {
        super.init()
        self.mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.mainNavigationController = self.mainStoryboard.instantiateViewController(withIdentifier: "SWMainNavigationController") as? SWNavigationController
        self.mainSplitViewController = self.mainStoryboard.instantiateViewController(withIdentifier: "SWMainSplitViewController") as? SWSplitViewController
    }
    
    class func newViewControllerWithIdentifier(_ identifer: String) -> UIViewController {
        let newVC = self.default.mainStoryboard.instantiateViewController(withIdentifier: identifer)
        newVC.view.backgroundColor = UIColor.white
        return newVC
    }
    func openWebViewControllerWithURL(_ url: URL) {
        let navigationController = self.mainNavigationController
        var presenterVC: UIViewController? = navigationController
        if let presentedVC = navigationController?.presentedViewController {
            presenterVC = presentedVC
        }
        var webUrl: URL? = url
        if webUrl?.scheme == nil {
            webUrl = URL(string: "https://\(url.absoluteString)")
        }
        if let webUrl = webUrl {
            let sfc = SFSafariViewController(url: webUrl, entersReaderIfAvailable: false)
            sfc.delegate = self
            sfc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            presenterVC?.present(sfc, animated: true, completion: nil)
        }
    }
    
    // MARK: + Private mmethods
    fileprivate func showMainNavigation(_ completion:(() -> Void)? = nil) {
        if let appDelegate = self.appDelegate, let window = appDelegate.window {
            if window.rootViewController != self.mainNavigationController {
                self.mainNavigationController = self.mainStoryboard.instantiateViewController(withIdentifier: "SWMainNavigationController") as? SWNavigationController
                self.mainSplitViewController = self.mainStoryboard.instantiateViewController(withIdentifier: "SWMainSplitViewController") as? SWSplitViewController
                UIView.transition(with: appDelegate.window!, duration: 0.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                    self.appDelegate?.window?.rootViewController = self.mainSplitViewController
                    self.appDelegate?.window?.makeKeyAndVisible()
                }, completion: { _ in
                    completion?()
                })
            }
            
            // Override point for customization after application launch.
            if let splitViewController = self.mainSplitViewController {
                let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
                navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
                splitViewController.delegate = self
            }
        }
    }
    fileprivate func dismissViewController(_ viewController: UIViewController) {
        if viewController.isModal() {
            viewController.dismiss(animated: true, completion: nil)
        } else if viewController.isPushed() {
            _ = viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: + Action mmethods
    func setupAppNavigation(_ completion:(() -> Void)? = nil) {
        //self.appDelegate?.window?.rootViewController = nil
        self.showMainNavigation()
    }
    func presentAlertController(_ alertController: UIAlertController!, completion:(() -> Void)?) {
        DispatchQueue.main.async(execute: {
            let navigationController = self.mainNavigationController
            navigationController?.present(alertController, animated: true, completion: { () -> Void in
                completion?()
            })
        })
    }
    func setMainNavigationViewController(_ viewController: UIViewController) {
        if self.appDelegate?.window?.rootViewController == self.mainNavigationController {
            DispatchQueue.main.async(execute: {
                self.mainNavigationController?.setViewControllers([viewController], animated: false)
            })
        }
    }
}

// MARK: - UISplitViewControllerDelegate methods -
extension SWNavigationCoordinator: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}


// MARK: - SFSafariViewControllerDelegate methods -
extension SWNavigationCoordinator: SFSafariViewControllerDelegate {
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
