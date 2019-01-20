//
//  SWLoadingController.swift
//  StarWars
//
//  Created by UreyMt on 1/21/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWLoadingController: NSObject {
    static let `default`: SWLoadingController = {
        let instance = SWLoadingController()
        return instance
    }()
    
    fileprivate(set) weak var appDelegate: AppDelegate?
    fileprivate var loadingViews: [String: SWLoadingView] = [String: SWLoadingView]()
    
    override init() {
        super.init()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: + Loading methods
    func showLoadingInView(_ view: UIView? = nil, id: String) {
        DispatchQueue.main.async(execute: {
            let key = "Loading_\(id)"
            if self.loadingViews[key] == nil {
                if let loadingView = SWLoadingView.loadFromNibNamed("SWLoadingView", bundle: Bundle.main, frame: nil) as? SWLoadingView {
                    loadingView.showInView(view)
                    self.loadingViews.updateValue(loadingView, forKey: key)
                }
            }
        })
    }
    func hideLoadingFromView(_ view: UIView? = nil, id: String) {
        delay(seconds: 1.0) {
            DispatchQueue.main.async(execute: {
                let key = "Loading_\(id)"
                if let loadingView = self.loadingViews[key] {
                    loadingView.dismissFromView(view)
                    self.loadingViews[key] = nil
                }
                self.loadingViews.removeValue(forKey: key)
            })
        }
    }
}
