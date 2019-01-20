//
//  SWIRepository.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

protocol SWIRepository {
    associatedtype TObject: SWIEntity
    
    var set: Set<TObject> { get }
    var objectsCreationDispatchGroup: DispatchGroup { get }
    var objectsCreationQueue: DispatchQueue { get }
    
    // MARK: - Initialization  methods
    func initializeRepository()
    
    // MARK: - Config  methods
    func configureRepository()
    func checkRepositoryConfiguration()
    
    // MARK: - Find Collection Of Items
    func find(_ transform: (TObject) throws -> Bool) rethrows -> [TObject]
    func find(_ isIncluded: (Set<TObject>) throws -> Bool) rethrows -> Set<TObject>
    func findWithPredicate(_ predicate: NSPredicate) -> Set<TObject>
    func findWithCompoundPredicate(_ compoundPredicates: NSCompoundPredicate) -> Set<TObject>
    
    func itemsWithId(_ id: NSNumber?) -> [TObject]
    func itemsWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ items: [TObject]) -> Void))
    
    func itemWithId(_ id: NSNumber?) -> TObject?
    func itemWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ item: TObject?) -> Void))
    
    // MARK: - Count Items
    func count(_ transform: (TObject) throws -> Bool) rethrows -> Int
    func count(_ isIncluded: (Set<TObject>) throws -> Bool) rethrows -> Int
    func countWithPredicate(_ predicate: NSPredicate) -> Int
    func countWithCompoundPredicate(_ compoundPredicates: NSCompoundPredicate) -> Int
    
    func count() -> Int
    func countAsync( _ completion: @escaping ((_ count: Int) -> Void))
    
    // MARK: - Insert Object
    func insertItems(_ items: [TObject]) -> [TObject]
    func insertItemsAsync(_ items: [TObject], _ completion: @escaping ((_ updatedItems: [TObject]) -> Void))
    
    func insertItem(_ item: TObject?) -> TObject?
    func insertItemAsync(_ item: TObject?, _ completion: @escaping ((_ updatedItem: TObject?) -> Void))
    
    // MARK: - Update Object
    func updateItems(_ items: [TObject]) -> [TObject]
    func updateItemsAsync(_ items: [TObject], _ completion: @escaping ((_ updatedItems: [TObject]) -> Void))
    
    func updateItem(_ item: TObject?) -> TObject?
    func updateItemAsync(_ item: TObject?, _ completion: @escaping ((_ updatedItem: TObject?) -> Void))
    
    // MARK: - Delete Collection Of Items
    func delete(_ transform: (TObject) throws -> Bool) rethrows -> Bool
    func delete(_ isIncluded: (Set<TObject>) throws -> Bool) rethrows -> Bool
    func deleteWithPredicate(_ predicate: NSPredicate) -> Bool
    func deleteWithCompoundPredicate(_ compoundPredicates: NSCompoundPredicate) -> Bool
    
    func deleteItemsWithId(_ id: NSNumber?) -> Bool
    func deleteItemsWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ deleted: Bool) -> Void))
    
    func deleteItemWithId(_ id: NSNumber?) -> Bool
    func deleteItemWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ deleted: Bool) -> Void))
    
    func deleteItem(_ item: TObject?) -> Bool
    func deleteItemAsync(_ item: TObject?, _ completion: @escaping ((_ deleted: Bool) -> Void))
    
    // MARK: - Repo Save
    func saveChanges() -> Bool
    func saveChanges(item: TObject?) -> Bool
    func saveChanges(items: Set<TObject>) -> Bool
    
    func saveChangesAsync(_ completion: @escaping ((_ saved: Bool) -> Void))
    func saveChangesAsync(item: TObject?, _ completion: @escaping ((_ saved: Bool) -> Void))
    func saveChangesAsync(items: Set<TObject>, _ completion: @escaping ((_ saved: Bool) -> Void))
}
