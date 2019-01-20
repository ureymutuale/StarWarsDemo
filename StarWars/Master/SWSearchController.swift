//
//  SWSearchController.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWSearchController: UISearchController, UISearchBarDelegate {
    lazy var _searchBar: SWSearchBar = {
        [unowned self] in
        let result = SWSearchBar(frame: CGRect.zero)
        result.delegate = self
        return result
        }()
    override var searchBar: UISearchBar {
        return _searchBar
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SWAppColor.DefaultScreen.statusBarStyle
    }
}

// MARK: - Custom UGCSearchBar -
class SWSearchBar: UISearchBar {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
