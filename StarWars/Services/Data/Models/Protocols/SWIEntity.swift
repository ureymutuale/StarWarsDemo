//
//  SWIEntity.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

protocol SWIEntity: SWSerializable, Hashable {
    var id: NSNumber? { get set }
    var url: String? { get set }
    var createdDate: Date? { get set }
    var editedDate: Date? { get set }
    var isRemoved: Bool { get set }
}


public protocol SWSerializable: Codable {
    func prettyJson() -> String?
    func printPrettyJson()
}

extension SWSerializable {
    public func prettyJson() -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodedData = try encoder.encode(self)
            return String(data: encodedData, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
    public func printPrettyJson() {
        NSLog("\(String(reflecting: self.self)) \(self.prettyJson() as AnyObject)")
    }
}
