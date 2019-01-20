//
//  SWFilm.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWFilm: SWEntity, SWIFilm {
    public var episodeId: NSNumber?
    public var title: String?
    public var openingCrawl: String?
    public var director: String?
    public var producer: String?
    public var releaseDate: Date?
    
    public fileprivate(set) var characters: Set<SWCharacter> = Set<SWCharacter>()
    
    public override init() {
        super.init()
    }
    deinit {
    }
    
    // MARK: - JSON Encoding/Decoding
    private enum CodingKeys: String, CodingKey {
        case episodeId
        case title
        case openingCrawl
        case director
        case producer
        case releaseDate
    }
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(episodeId?.intValue, forKey: .episodeId)
        try container.encode(title, forKey: .title)
        try container.encode(openingCrawl, forKey: .openingCrawl)
        try container.encode(director, forKey: .director)
        try container.encode(producer, forKey: .producer)
        try container.encode(releaseDate, forKey: .releaseDate)
    }
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        episodeId = NSNumber(value: try values.decode(Int.self, forKey: .episodeId))
        title = try values.decode(String.self, forKey: .title)
        openingCrawl = try values.decode(String.self, forKey: .openingCrawl)
        director = try values.decode(String.self, forKey: .director)
        producer = try values.decode(String.self, forKey: .producer)
        releaseDate = try values.decode(Date.self, forKey: .releaseDate)
    }
    // MARK: -
    
    // MARK: - Film Characters
    public func addCharacters(_ characters: Set<SWCharacter>, clean: Bool = false) -> Set<SWCharacter> {
        var addedItems: Set<SWCharacter> = Set<SWCharacter>()
        if clean {
            self.characters.removeAll()
        }
        for item in characters {
            addedItems.insert(self.characters.insert(item).memberAfterInsert)
        }
        return addedItems
    }
    public func addCharactersAsync(_ characters: Set<SWCharacter>, clean: Bool = false, _ completion: @escaping ((Set<SWCharacter>) -> Void)) {
        let items = self.addCharacters(characters, clean: clean)
        completion(items)
    }
    public func removeCharacters(_ characters: Set<SWCharacter>) -> Set<SWCharacter> {
        var removedItems: Set<SWCharacter> = Set<SWCharacter>()
        for item in characters {
            if let it = self.characters.remove(item) {
                removedItems.insert(it)
            }
        }
        return removedItems
    }
    public func removeCharactersAsync(_ characters: Set<SWCharacter>, _ completion: @escaping ((Set<SWCharacter>) -> Void)) {
        let items = self.removeCharacters(characters)
        completion(items)
    }
}
