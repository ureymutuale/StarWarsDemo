//
//  SWFilmDetailsViewController.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWFilmDetailsViewController: SWViewController {
    
    var film: SWFilm?
    
    fileprivate var isLoadinFilmDetails: Bool = false
    
    // MARK: + Initialization  methods
    convenience init(fromNib: Bool = true) {
        if fromNib {
            self.init(nibName: "SWFilmDetailsViewController", bundle: nil)
        } else {
            self.init(nibName: nil, bundle: nil)
        }
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    // MARK: + Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadFilmDetails(forceRefresh: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SWAppColor.FilmDetailsScreen.statusBarStyle
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSLog("\(NSStringFromClass(self.classForCoder)) didReceiveMemoryWarning")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
        self.view.backgroundColor = SWAppColor.FilmDetailsScreen.backgroundColor
        self.navigationController?.setupNavigationControllerWithBarColor(barColor: SWAppColor.FilmDetailsScreen.Navigationbar.barColor, tintColor: SWAppColor.FilmDetailsScreen.Navigationbar.itemTintColor, titleColor: SWAppColor.FilmDetailsScreen.Navigationbar.titleColor, titleFont: SWAppFont.FilmDetailsScreen.Navigationbar.titleFont, hidden: false)
        self.navigationController?.setBottomBorderColor(SWAppColor.FilmDetailsScreen.Navigationbar.borderColor, height: 0.2)
        self.setupNavigationBarItems()
    }
    override func forceViewReload() {
        super.forceViewReload()
    }
    
    // MARK: + Private methods
    fileprivate func setupNavigationBarItems() {
        var navigationItem: UINavigationItem? = self.navigationItem
        if let navItem = self.splitViewController?.navigationItem {
            navigationItem = navItem
        }
        navigationItem?.title = "Film Details"
        if let title = self.film?.title {
            navigationItem?.title = title
        }
        let backImage = self.isPushed() ? UIImage(named: "icon_arrow_left") : UIImage(named: "icon_arrow_down")
        let backBarButton = UINavigationController.barButtonItemWithImage(backImage, color: SWAppColor.FilmsScreen.Navigationbar.itemTintColor, selectedColor: SWAppColor.FilmsScreen.Navigationbar.highlightedItemTintColor, size: CGSize(width: 30, height: 30), target: self, action: #selector(self.dismissCurrentViewController(_:)))
        navigationItem?.leftBarButtonItem = backBarButton
        
        if let spliViewController = self.splitViewController {
            navigationItem?.leftBarButtonItem = splitViewController?.displayModeButtonItem
            navigationItem?.leftItemsSupplementBackButton = true
        }
    }
    fileprivate func loadFilmDetails(forceRefresh: Bool = false) {
        if self.isLoadinFilmDetails {
            return
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            self.isLoadinFilmDetails = true
            SWFilmApiClient.default.fetchDetailsForFilm(self.film, filter: nil, completion: { (film, success, message) in
                let isLocal = false
                NSLog("FETCH - FILM: \(film) UPDATED: \(success) LOCAL: \(isLocal) MSG: \(message)")
                if success || !isLocal || forceRefresh {
                    self.film = film
                    self.reloadContent()
                }
                self.isLoadinFilmDetails = false
            })
        })
    }
    fileprivate func reloadContent() {
        DispatchQueue.main.async(execute: { () -> Void in
            
        })
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
    override func keyboardWillChangeFrame(_ notification: Notification) {
        super.keyboardWillChangeFrame(notification)
    }
    
}
