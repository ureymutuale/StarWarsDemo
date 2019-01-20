//
//  SWAppCell.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWAppCell: NSObject {
    class var  SWFilmTableViewCell: (String, UINib) {
        return  ("SWFilmTableViewCell", UINib(nibName: "SWFilmTableViewCell", bundle: Bundle.main))
    }
    class var  SWCharacterCollectionViewCell: (String, UINib) {
        return  ("SWCharacterCollectionViewCell", UINib(nibName: "SWCharacterCollectionViewCell", bundle: Bundle.main))
    }
}
