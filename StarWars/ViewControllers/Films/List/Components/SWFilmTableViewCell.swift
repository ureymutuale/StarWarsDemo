//
//  SWFilmTableViewCell.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWFilmTableViewCell: UITableViewCell {

    @IBOutlet public fileprivate(set) weak var containerView: UIView!
    @IBOutlet public fileprivate(set) weak var titleLabel: UILabel!
    @IBOutlet public fileprivate(set) weak var detailsLabel: UILabel!
    
    public fileprivate(set) var indexPath: IndexPath!
    public fileprivate(set) var film: SWFilm?
    public var isCellSelected: Bool = false
    
    // MARK: + Initialization  methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.applySubviewsAppearance()
    }
    deinit {
        
    }
    
    // MARK: + Overriden methods
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.applySubviewsAppearance()
    }
    override public func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: + View Setup methods
    fileprivate func applySubviewsAppearance() {
        let bgColor = isCellSelected ? SWAppColor.FilmsScreen.FilmItemCell.selectedBackgroundColor : SWAppColor.FilmsScreen.FilmItemCell.backgroundColor
        let borderColor = isCellSelected ? SWAppColor.FilmsScreen.FilmItemCell.selectedBorderColor : SWAppColor.FilmsScreen.FilmItemCell.borderColor
        let titleColor = isCellSelected ? SWAppColor.FilmsScreen.FilmItemCell.selectedTitleTextColor : SWAppColor.FilmsScreen.FilmItemCell.titleTextColor
        let detailsColor = isCellSelected ? SWAppColor.FilmsScreen.FilmItemCell.selectedDetailsTextColor : SWAppColor.FilmsScreen.FilmItemCell.detailsTextColor
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.cardViewSetup()
        self.containerView.backgroundColor = bgColor
        self.containerView.setBorder(borderColor, borderWidth: 2.0)
        
        self.titleLabel.textColor = titleColor
        self.titleLabel.font = SWAppFont.FilmsScreen.FilmItemCell.titleTextFont
        
        self.detailsLabel.textColor = detailsColor
        self.detailsLabel.font = SWAppFont.FilmsScreen.FilmItemCell.detailsTextFont
    }
    fileprivate func cardViewSetup() {
        DispatchQueue.main.async(execute: {
            self.containerView.alpha = 1.0
            self.containerView.layer.masksToBounds = false
            self.containerView.layer.cornerRadius = 1
            self.containerView.layer.shadowOffset = CGSize(width: 2, height: 1)
            self.containerView.layer.shadowRadius = 2
            self.containerView.layer.shadowPath = UIBezierPath(rect: self.containerView.layer.bounds).cgPath
            self.containerView.layer.shadowOpacity = 0.35
            self.containerView.layer.shouldRasterize = true
            self.containerView.layer.rasterizationScale = UIScreen.main.scale
        })
    }
    
    // MARK: + Private methods
    fileprivate func loadContent() {
        var title = ""
        var details = ""
        if let film = self.film {
            if let _title = film.title {
                title = _title
            }
            if let _release = film.releaseDate {
                let formatter = SWDateFormatter.fullDateTimeFormatter
                details = formatter.string(from: _release)
            }
            
        }
        self.titleLabel.text = title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.detailsLabel.text = details.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // MARK: + Action methods
    
    // MARK: + Public methods
    func loadFilm(film: SWFilm?, indexPath: IndexPath, selected: Bool) {
        self.film = film
        self.indexPath = indexPath
        self.isCellSelected = selected
        self.loadContent()
    }
    
}
