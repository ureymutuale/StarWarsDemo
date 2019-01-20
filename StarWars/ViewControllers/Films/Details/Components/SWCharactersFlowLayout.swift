//
//  SWCharactersFlowLayout.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWCharactersFlowLayout: UICollectionViewFlowLayout {
    fileprivate let kCellVerticalPadding: CGFloat = (isIPad() ? 0:0)
    fileprivate let kCellHorizontalPadding: CGFloat = (isIPad() ? 0:0)
    fileprivate let kCellInterimSpace: CGFloat = (isIPad() ? 8:5)
    fileprivate(set) var numberOfColumns: CGFloat {
        get {
            if let collectionView = self.collectionView {
                var columns: CGFloat = 3
                if collectionView.isHorizontalSizeClassRegularWidth() {
                    if isIPad() {
                        columns = 5
                    }
                    if isLandscape() {
                        columns += 1
                    }
                }
                return columns
            }
            return 0
        }
        set {
            
        }
    }
    var itemComputedSize: CGSize {
        if let collectionView = self.collectionView {
            let itemsPerColumns = CGFloat(max(self.numberOfColumns, 1))
            let itemsPerRow = CGFloat(1)
            let totalXSpacing = (self.minimumInteritemSpacing * (itemsPerColumns - 1.0)) + ((self.sectionInset.left + self.sectionInset.right) * 1) + ((collectionView.contentInset.left + collectionView.contentInset.right) * 1)
            //let totalYSpacing: CGFloat = (self.minimumInteritemSpacing * (itemsPerRow - 1.0)) + ((self.sectionInset.top + self.sectionInset.bottom) * 1) + ((collectionView.contentInset.top + collectionView.contentInset.bottom) * 1)
            //print("-Teams: totalXSpacing: \(totalXSpacing)")
            //print("-Teams: totalYSpacing: \(totalYSpacing)")
            var itemWidth: CGFloat = (collectionView.bounds.size.width - totalXSpacing)/itemsPerColumns
            let itemHeight: CGFloat = itemWidth
            let size =  CGSize(width: itemWidth, height: itemHeight)
            return size
        }
        return CGSize.zero
    }
    
    override init() {
        super.init()
    }
    deinit {
        NSLog("\(NSStringFromClass(self.classForCoder)) deinit")
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func prepare() {
        super.prepare()
        headerReferenceSize = CGSize.zero
        footerReferenceSize = CGSize.zero
        sectionInset = UIEdgeInsets(top: kCellVerticalPadding, left: kCellHorizontalPadding, bottom: kCellVerticalPadding, right: kCellHorizontalPadding)
        if #available(iOS 11.0, *) {
            sectionInsetReference = SectionInsetReference.fromContentInset
        }
        minimumLineSpacing = kCellInterimSpace
        minimumInteritemSpacing = kCellInterimSpace
        scrollDirection = .vertical
    }
}
