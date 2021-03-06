//
//  SWFilmDetailsViewController.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWFilmDetailsViewController: SWViewController {
    
    @IBOutlet fileprivate(set) weak var detailsContainerView: UIView!
    @IBOutlet fileprivate(set) weak var posterImageView: UIImageView!
    @IBOutlet fileprivate(set) weak var episodeLabel: UILabel!
    @IBOutlet fileprivate(set) weak var textContainerView: UIView!
    @IBOutlet fileprivate(set) weak var titleLabel: UILabel!
    @IBOutlet fileprivate(set) weak var detailsLabel: UILabel!
    @IBOutlet fileprivate(set) weak var introLabel: UILabel!
    
    @IBOutlet public fileprivate(set) weak var charactersContainerView: UIView!
    @IBOutlet public fileprivate(set) weak var charactersLeftAccessoryView: UIView!
    @IBOutlet public fileprivate(set) weak var charactersLeftAccessoryImageView: UIImageView!
    @IBOutlet public fileprivate(set) weak var charactersLabel: UILabel!
    @IBOutlet public fileprivate(set) weak var charactersCollectionView: UICollectionView!
    @IBOutlet public fileprivate(set) weak var charactersCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var film: SWFilm?
    fileprivate(set) var filmCharacters: [SWCharacter] = []
    
    fileprivate var isLoadinFilmDetails: Bool = false
    fileprivate var isLoadinCharacters: Bool = false
    
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
        self.reloadContent()
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
        self.charactersCollectionView.dataSource = self
        self.charactersCollectionView.delegate = self
        self.charactersCollectionView.register(SWAppCell.SWCharacterCollectionViewCell.1, forCellWithReuseIdentifier: SWAppCell.SWCharacterCollectionViewCell.0)
        self.charactersCollectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.charactersCollectionView.setContentOffset(CGPoint.zero, animated: true)
        self.charactersCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
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
        
        //Details Container
        self.detailsContainerView.backgroundColor = SWAppColor.FilmDetailsScreen.DetailsContainer.backgroundColor
        self.detailsContainerView.setBorder(SWAppColor.FilmDetailsScreen.DetailsContainer.borderColor, borderWidth: 1.0)
        
        self.episodeLabel.textColor = SWAppColor.FilmDetailsScreen.DetailsContainer.episodeTextColor
        self.episodeLabel.font = SWAppFont.FilmDetailsScreen.DetailsContainer.episodeTextFont
        
        self.textContainerView.backgroundColor = SWAppColor.FilmDetailsScreen.DetailsContainer.TextContainer.backgroundColor
        self.textContainerView.setBorder(SWAppColor.FilmDetailsScreen.DetailsContainer.TextContainer.borderColor, borderWidth: 1.0)
        
        self.titleLabel.textColor = SWAppColor.FilmDetailsScreen.DetailsContainer.TextContainer.titleTextColor
        self.titleLabel.font = SWAppFont.FilmDetailsScreen.DetailsContainer.TextContainer.titleTextFont
        
        self.detailsLabel.textColor = SWAppColor.FilmDetailsScreen.DetailsContainer.TextContainer.detailsTextColor
        self.detailsLabel.font = SWAppFont.FilmDetailsScreen.DetailsContainer.TextContainer.detailsTextFont
        
        self.introLabel.textColor = SWAppColor.FilmDetailsScreen.DetailsContainer.TextContainer.introTextColor
        self.introLabel.font = SWAppFont.FilmDetailsScreen.DetailsContainer.TextContainer.introTextFont
        
        //Characters Section
        self.charactersContainerView.addTopSeparatorLine(SWAppColor.FilmDetailsScreen.CharactersContainer.separatorColor, height: 0.5, multiplier: 1.0, xOffset: 0, yOffset: -5)
        self.charactersContainerView.backgroundColor = SWAppColor.FilmDetailsScreen.CharactersContainer.backgroundColor
        self.charactersContainerView.setBorder(SWAppColor.FilmDetailsScreen.CharactersContainer.borderColor, borderWidth: 1.0)
        
        self.charactersLeftAccessoryView.backgroundColor = SWAppColor.FilmDetailsScreen.CharactersContainer.LeftAccessoryView.backgroundColor
        self.charactersLeftAccessoryView.setBorder(SWAppColor.FilmDetailsScreen.CharactersContainer.LeftAccessoryView.borderColor, borderWidth: 1.0)
        self.charactersLeftAccessoryView.layer.cornerRadius = self.charactersLeftAccessoryView.frame.size.height/2
        self.charactersLeftAccessoryView.clipsToBounds = true
        
        self.charactersLeftAccessoryImageView.image = self.charactersLeftAccessoryImageView.image?.imageWithColor(SWAppColor.FilmDetailsScreen.CharactersContainer.LeftAccessoryView.iconTintColor)
        
        self.charactersLabel.textColor = SWAppColor.FilmDetailsScreen.CharactersContainer.headerTextColor
        self.charactersLabel.font = SWAppFont.FilmDetailsScreen.CharactersContainer.headerTextFont
    }
    override func forceViewReload() {
        super.forceViewReload()
    }
    
    // MARK: + Private methods
    fileprivate func setupNavigationBarItems() {
        var navigationItem: UINavigationItem? = self.navigationItem
        if let navItem = self.splitViewController?.navigationItem {
//            navigationItem = navItem
        }
        navigationItem?.title = "Film Details"
        if let title = self.film?.title {
            navigationItem?.title = title
        }
        let backImage = self.isPushed() ? UIImage(named: "icon_arrow_left") : UIImage(named: "icon_arrow_down")
        let backBarButton = UINavigationController.barButtonItemWithImage(backImage, color: SWAppColor.FilmsScreen.Navigationbar.itemTintColor, selectedColor: SWAppColor.FilmsScreen.Navigationbar.highlightedItemTintColor, size: CGSize(width: 30, height: 30), target: self, action: #selector(self.dismissCurrentViewController(_:)))
        
        if let _ = self.splitViewController {
            navigationItem?.leftBarButtonItem = splitViewController?.displayModeButtonItem
            navigationItem?.leftItemsSupplementBackButton = true
        } else if self.isModal() || self.isPushed() {
            navigationItem?.leftBarButtonItem = backBarButton
        }
    }
    fileprivate func loadFilmDetails(forceRefresh: Bool = false) {
        if self.isLoadinFilmDetails {
            return
        }
        SWLoadingController.default.showLoadingInView(self.view, id: "FilmDetails")
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            self.isLoadinFilmDetails = true
            SWFilmApiClient.default.fetchDetailsForFilm(self.film, filter: nil, completion: { (film, success, message) in
                let isLocal = false
                NSLog("FETCH - FILM: \(String(describing: film)) UPDATED: \(success) LOCAL: \(isLocal) MSG: \(message)")
                if success || !isLocal || forceRefresh {
                    self.film = film
                    self.reloadContent()
                }
                self.isLoadinFilmDetails = false
                SWLoadingController.default.hideLoadingFromView(self.view, id: "FilmDetails")
            })
        })
    }
    fileprivate func loadFilmCharacters() {
        func resizeCharactersCollectionView() {
            var height: CGFloat = 0
            for section in 0..<self.numberOfSections(in: self.charactersCollectionView) {
                let items = self.collectionView(self.charactersCollectionView, numberOfItemsInSection: section)
                if let layout = self.charactersCollectionView.collectionViewLayout as? SWCharactersFlowLayout {
                    let itemHeight = layout.itemComputedSize.height
                    height += itemHeight * (ceil(CGFloat(items)/layout.numberOfColumns) + 0.2)
                }
            }
            UIView.animate(withDuration: 0.3) {
                self.charactersCollectionViewHeightConstraint.constant = height + 40
                self.view.layoutIfNeeded()
                self.applySubviewsAppearance()
            }
        }
        if self.isLoadinCharacters {
            return
        }
        SWLoadingController.default.showLoadingInView(self.charactersCollectionView, id: "CharactersList")
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        self.filmCharacters.removeAll()
        var characters: [SWCharacter] = []
        if let _characters = self.film?.characters {
            characters = Array(_characters)
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
            self.isLoadinCharacters = true
            for character in characters {
                dispatchGroup.enter()
                SWCharacterApiClient.default.fetchDetailsForCharacter(character, filter: nil, completion: { (updatedCharacter, success, message) in
                    if let updatedCharacter = updatedCharacter {
                        self.filmCharacters.append(updatedCharacter)
                    }
                    dispatchGroup.leave()
                })
            }
            if characters.count <= 0 {
                dispatchGroup.enter()
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: queue, execute: {
                DispatchQueue.main.sync {
                    self.isLoadinCharacters = false
                    self.charactersCollectionView.reloadData()
                    resizeCharactersCollectionView()
                    SWLoadingController.default.hideLoadingFromView(self.charactersCollectionView, id: "CharactersList")
                }
            })
        }
    }
    fileprivate func reloadContent() {
        DispatchQueue.main.async(execute: { () -> Void in
            var episode = ""
            var title = ""
            var details = ""
            var intro = ""
            if let _episodeId = self.film?.episodeId {
                episode = " Episode \(_episodeId) "
            }
            if let _title = self.film?.title {
                title = _title
            }
            if let _release = self.film?.releaseDate {
                let formatter = SWDateFormatter.fullDateTimeFormatter
                details = "Released on \(formatter.string(from: _release))"
            }
            if let _director = self.film?.director {
                details += "\nDirected by: \(_director)"
            }
            if let _producer = self.film?.producer {
                details += "\nProduced by: \(_producer)"
            }
            if let _intro = self.film?.openingCrawl {
                intro = _intro
            }
            self.episodeLabel.text = episode
            self.titleLabel.text = title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.detailsLabel.text = details.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.introLabel.text = intro.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.loadFilmCharacters()
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

// MARK: - UICollectionViewDataSource
extension SWFilmDetailsViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmCharacters.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: SWAppCell.SWCharacterCollectionViewCell.0, for: indexPath)
        if let characterCell = cell as? SWCharacterCollectionViewCell {
            var character: SWCharacter? = nil
            if indexPath.row < self.filmCharacters.count {
                character = self.filmCharacters[indexPath.row]
            }
            characterCell.loadCharacter(character: character, indexPath: indexPath)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SWFilmDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1, animations: {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        })
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGSize.zero
        if let layout = collectionView.collectionViewLayout as? SWCharactersFlowLayout {
            cellSize = layout.itemComputedSize
        }
        return cellSize
    }
}
