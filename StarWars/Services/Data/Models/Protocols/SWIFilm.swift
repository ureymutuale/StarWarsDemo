//
//  SWIFilm.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

protocol SWIFilm: SWIEntity {
    var episodeId: NSNumber? { get set }
    var title: String? { get set }
    var openingCrawl: String? { get set }
    var director: String? { get set }
    var producer: String? { get set }
    var releaseDate: Date? { get set }
    
    var characters: Set<SWCharacter> { get }
}
