//
//  SWICharacter.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

protocol SWICharacter: SWIEntity {
    var name: String? { get set }
    var height: Double { get set }
    var mass: Double { get set }
    var hairColor: String? { get set }
    var skinColor: String? { get set }
    var eyeColor: String? { get set }
    var birthYear: String? { get set }
    var gender: String? { get set }
    
    var films: Set<SWFilm> { get }
}
