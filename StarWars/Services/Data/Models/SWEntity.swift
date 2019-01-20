//
//  SWEntity.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWEntity: NSObject, SWIEntity {
    var id: NSNumber?
    var url: String?
    var createdDate: Date? = Date()
    var editedDate: Date? = Date()
    var isRemoved: Bool = false
    
    public override init() {
        super.init()
    }
    deinit {
    }
    
    // MARK: - JSON Encoding/Decoding
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case createdDate = "created"
        case editedDate = "edited"
        case isRemoved = "removed"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id?.intValue, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(editedDate, forKey: .editedDate)
        try container.encode(isRemoved, forKey: .isRemoved)
        
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = NSNumber(value: try values.decode(Int.self, forKey: .id))
        url = try values.decode(String.self, forKey: .url)
        createdDate = try values.decode(Date.self, forKey: .createdDate)
        editedDate = try values.decode(Date.self, forKey: .editedDate)
        isRemoved = try values.decode(Bool.self, forKey: .isRemoved)
    }
    // MARK: -
}
