//
//  SWIHelper.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

public protocol SWIHelper {
    associatedtype TObject: Any
    
    static var creationDispatchGroup: DispatchGroup { get }
    static var creationQueue: DispatchQueue { get }
    
    static func itemsFromDict(_ dict: Any?) -> (items: [TObject], updated: Bool)
    static func itemsFromDictAsync(_ dict: Any?, _ completion: @escaping ((_ items: [TObject], _ updated: Bool) -> Void))
    
    static func itemFromDict(_ dict: Any?, oldItem: TObject?) -> (item: TObject?, updated: Bool)
    static func itemFromDictAsync(_ dict: Any?, oldItem: TObject?, _ completion: @escaping ((_ item: TObject?, _ updated: Bool) -> Void))
}
