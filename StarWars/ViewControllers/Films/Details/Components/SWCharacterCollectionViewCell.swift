//
//  SWCharacterCollectionViewCell.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWCharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet public fileprivate(set) weak var containerView: UIView!
    @IBOutlet public fileprivate(set) weak var avatarImageView: UIImageView!
    @IBOutlet public fileprivate(set) weak var nameLabel: UILabel!
    
    public fileprivate(set) var character: SWCharacter?
    public fileprivate(set) var indexPath: IndexPath!
    
    // MARK: + Initialization  methods
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applySubviewsAppearance()
    }
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.applySubviewsAppearance()
    }
    deinit {
        NSLog("\(NSStringFromClass(self.classForCoder)) deinit")
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
        let bgColor = UIColor.randomColor()//SWAppColor.FilmDetailsScreen.CharactersContainer.CharacterItemCell.backgroundColor
        let borderColor = SWAppColor.FilmDetailsScreen.CharactersContainer.CharacterItemCell.borderColor
        self.backgroundColor = bgColor
        self.contentView.backgroundColor = bgColor
        self.setBorder(borderColor, borderWidth: 3.0)
        
        self.containerView.backgroundColor = UIColor.clear
        
        self.cardViewSetup()
        
        self.nameLabel.textColor = SWAppColor.FilmDetailsScreen.CharactersContainer.CharacterItemCell.nameTextColor
        self.nameLabel.font = SWAppFont.FilmDetailsScreen.CharactersContainer.CharacterItemCell.nameTextFont
    }
    fileprivate func cardViewSetup() {
        DispatchQueue.main.async(execute: {
            self.alpha = 1.0
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 1
            self.layer.shadowOffset = CGSize(width: 2, height: 1)
            self.layer.shadowRadius = 2
            self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
            self.layer.shadowOpacity = 0.35
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        })
    }
    
    // MARK: + Private methods
    fileprivate func loadContent() {
        if let character = self.character {
            var name = ""
            if let _name = character.name {
                name = _name
            }
            self.nameLabel.text = name
        }
    }
    
    // MARK: + Action methods
    
    // MARK: + Public methods
    func loadCharacter(character: SWCharacter?, indexPath: IndexPath) {
        self.character = character
        self.indexPath = indexPath
        self.loadContent()
    }

}
