//
//  SWCharacter.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWCharacter: SWEntity, SWICharacter {
    public var name: String?
    public var height: Double = -1
    public var mass: Double = -1
    public var hairColor: String?
    public var skinColor: String?
    public var eyeColor: String?
    public var birthYear: String?
    public var gender: String?
    
    public fileprivate(set) var films: Set<SWFilm> = Set<SWFilm>()
    
    public override init() {
        super.init()
    }
    deinit {
    }
    
    // MARK: - JSON Encoding/Decoding
    private enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor
        case skinColor
        case eyeColor
        case birthYear
        case gender
    }
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(height, forKey: .height)
        try container.encode(mass, forKey: .mass)
        try container.encode(hairColor, forKey: .hairColor)
        try container.encode(skinColor, forKey: .skinColor)
        try container.encode(eyeColor, forKey: .eyeColor)
        try container.encode(birthYear, forKey: .birthYear)
        try container.encode(gender, forKey: .gender)
        
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        height = try values.decode(Double.self, forKey: .height)
        mass = try values.decode(Double.self, forKey: .mass)
        hairColor = try values.decode(String.self, forKey: .hairColor)
        skinColor = try values.decode(String.self, forKey: .skinColor)
        eyeColor = try values.decode(String.self, forKey: .eyeColor)
        birthYear = try values.decode(String.self, forKey: .birthYear)
        gender = try values.decode(String.self, forKey: .gender)
    }
    // MARK: -
    
    // MARK: - Character Films
    public func addFilms(_ films: Set<SWFilm>, clean: Bool = false) -> Set<SWFilm> {
        var addedItems: Set<SWFilm> = Set<SWFilm>()
        if clean {
            self.films.removeAll()
        }
        for item in films {
            addedItems.insert(self.films.insert(item).memberAfterInsert)
        }
        return addedItems
    }
    public func addFilmsAsync(_ films: Set<SWFilm>, clean: Bool = false, _ completion: @escaping ((Set<SWFilm>) -> Void)) {
        let items = self.addFilms(films, clean: clean)
        completion(items)
    }
    public func removeFilms(_ films: Set<SWFilm>) -> Set<SWFilm> {
        var removedItems: Set<SWFilm> = Set<SWFilm>()
        for item in films {
            if let it = self.films.remove(item) {
                removedItems.insert(it)
            }
        }
        return removedItems
    }
    public func removeFilmsAsync(_ films: Set<SWFilm>, _ completion: @escaping ((Set<SWFilm>) -> Void)) {
        let items = self.removeFilms(films)
        completion(items)
    }
}
