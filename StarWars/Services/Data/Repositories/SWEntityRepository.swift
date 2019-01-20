//
//  SWEntityRepository.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWEntityRepository<TEntity: SWEntity>: SWIRepository {
    public typealias TRepo = SWEntityRepository
    public typealias TObject = TEntity
    
    public internal(set) lazy var set: Set<TEntity> = Set<TEntity>()
    public internal(set) var objectsCreationDispatchGroup: DispatchGroup = DispatchGroup()
    public internal(set) var objectsCreationQueue: DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    //    public static let `default`: TRepo = {
    //        let instance = TRepo()
    //        instance.initializeRepository()
    //        return instance
    //    }()
    
    public weak var delegate: SWRepositoryDelegate?
    
    // MARK: - Initialization  methods
    public func initializeRepository() {
        self.configureRepository()
    }
    
    // MARK: - Config  methods
    public func configureRepository() {
        
    }
    public func checkRepositoryConfiguration() {
        
    }
    
    // MARK: - Find Collection Of Items
    public func find(_ transform: (TEntity) throws -> Bool) rethrows -> [TEntity] {
        return try set.filter(transform).filter {$0.isRemoved == false}
    }
    public func find(_ isIncluded: (Set<TEntity>) throws -> Bool) rethrows -> Set<TEntity> {
        return Set<TEntity>()
    }
    public func findWithPredicate(_ predicate: NSPredicate) -> Set<TEntity> {
        return (set as NSSet).filtered(using: predicate) as? Set<TEntity> ?? Set<TEntity>()
    }
    public func findWithCompoundPredicate(_ compoundPredicates: NSCompoundPredicate) -> Set<TEntity> {
        return (set as NSSet).filtered(using: compoundPredicates) as? Set<TEntity> ?? Set<TEntity>()
    }
    
    public func itemsWithId(_ id: NSNumber?) -> [TEntity] {
        return self.find { (item) -> Bool in
            item.id == id
        }
    }
    public func itemsWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ items: [TEntity]) -> Void)) {
        completion(self.itemsWithId(id))
    }
    
    public func itemWithId(_ id: NSNumber?) -> TEntity? {
        return self.itemsWithId(id).first
    }
    public func itemWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ item: TEntity?) -> Void)) {
        completion(self.itemWithId(id))
    }
    
    // MARK: - Count Items
    public func count(_ transform: (TEntity) throws -> Bool) rethrows -> Int {
        return try self.find(transform).count
    }
    public func count(_ isIncluded: (Set<TEntity>) throws -> Bool) rethrows -> Int {
        return try self.find(isIncluded).count
    }
    public func countWithPredicate(_ predicate: NSPredicate) -> Int {
        return self.findWithPredicate(predicate).count
    }
    public func countWithCompoundPredicate(_ compoundPredicates: NSCompoundPredicate) -> Int {
        return self.findWithCompoundPredicate(compoundPredicates).count
    }
    public func count() -> Int {
        return set.count
    }
    public func countAsync( _ completion: @escaping ((_ count: Int) -> Void)) {
        completion(count())
    }
    
    // MARK: - Insert Object
    public func insertItems(_ items: [TEntity]) -> [TEntity] {
        var insertedItems: [TEntity] = []
        for item in items {
            if let insertedItem = self.insertItem(item) {
                insertedItems.append(insertedItem)
            }
        }
        return self.updateItems(insertedItems)
    }
    public func insertItemsAsync(_ items: [TEntity], _ completion: @escaping ((_ insertedItems: [TEntity]) -> Void)) {
        completion(self.insertItems(items))
    }
    
    public func insertItem(_ item: TEntity?) -> TEntity? {
        if let item = item {
            let inserted = set.insert(item)
            SWRepositoryObserver.postRepository(repo: self, hasInsertedObject: item)
            self.delegate?.repository(self, hasInsertedObject: item)
            return self.updateItem(inserted.memberAfterInsert)
        }
        return nil
    }
    public func insertItemAsync(_ item: TEntity?, _ completion: @escaping ((_ insertedItem: TEntity?) -> Void)) {
        completion(self.insertItem(item))
    }
    
    // MARK: - Update Object
    public func updateItems(_ items: [TEntity]) -> [TEntity] {
        var updatedItems: [TEntity] = []
        for item in items {
            if let updatedItem = self.updateItem(item) {
                updatedItems.append(updatedItem)
            }
        }
        return updatedItems
    }
    public func updateItemsAsync(_ items: [TEntity], _ completion: @escaping ((_ updatedItems: [TEntity]) -> Void)) {
        completion(self.updateItems(items))
    }
    
    public func updateItem(_ item: TEntity?) -> TEntity? {
        SWRepositoryObserver.postRepository(repo: self, hasUpdatedObject: item)
        self.delegate?.repository(self, hasUpdatedObject: item)
        return item
    }
    public func updateItemAsync(_ item: TEntity?, _ completion: @escaping ((_ updatedItem: TEntity?) -> Void)) {
        completion(self.updateItem(item))
    }
    
    // MARK: - Delete Collection Of Items
    public func delete(_ transform: (TEntity) throws -> Bool) rethrows -> Bool {
        var deleted = false
        let items = try self.find(transform)
        for item in items {
            let d = self.deleteItem(item)
            if !deleted {
                deleted = d
            }
        }
        return deleted
    }
    public func delete(_ isIncluded: (Set<TEntity>) throws -> Bool) rethrows -> Bool {
        var deleted = false
        let items = try self.find(isIncluded)
        for item in items {
            let d = self.deleteItem(item)
            if !deleted {
                deleted = d
            }
        }
        return deleted
    }
    public func deleteWithPredicate(_ predicate: NSPredicate) -> Bool {
        var deleted = false
        let items = self.findWithPredicate(predicate)
        for item in items {
            let d = self.deleteItem(item)
            if !deleted {
                deleted = d
            }
        }
        return deleted
    }
    public func deleteWithCompoundPredicate(_ compoundPredicates: NSCompoundPredicate) -> Bool {
        var deleted = false
        let items = self.findWithCompoundPredicate(compoundPredicates)
        for item in items {
            let d = self.deleteItem(item)
            if !deleted {
                deleted = d
            }
        }
        return deleted
    }
    
    public func deleteItemsWithId(_ id: NSNumber?) -> Bool {
        var deleted = false
        let items = self.itemsWithId(id)
        for item in items {
            let d = self.deleteItem(item)
            if !deleted {
                deleted = d
            }
        }
        return deleted
    }
    public func deleteItemsWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ deleted: Bool) -> Void)) {
        completion(self.deleteItemsWithId(id))
    }
    
    public func deleteItemWithId(_ id: NSNumber?) -> Bool {
        return self.deleteItem(self.itemWithId(id))
    }
    public func deleteItemWithIdAsync(_ id: NSNumber?, _ completion: @escaping ((_ deleted: Bool) -> Void)) {
        completion(self.deleteItemWithId(id))
    }
    
    public func deleteItem(_ item: TEntity?) -> Bool {
        SWRepositoryObserver.postRepository(repo: self, hasDeletedObject: item)
        self.delegate?.repository(self, hasDeletedObject: item)
        return true
    }
    public func deleteItemAsync(_ item: TEntity?, _ completion: @escaping ((_ deleted: Bool) -> Void)) {
        completion(self.deleteItem(item))
    }
    
    // MARK: - Repo Save
    public func saveChanges() -> Bool {
        return self.saveChanges(item: nil)
    }
    public func saveChanges(item: TEntity?) -> Bool {
        SWRepositoryObserver.postRepository(repo: self, hasSavedObject: item)
        self.delegate?.repository(self, hasSavedObject: item)
        return true
    }
    public func saveChanges(items: Set<TEntity>) -> Bool {
        var saved = false
        for item in items {
            let s = self.saveChanges(item: item)
            if !saved {
                saved = s
            }
        }
        return saved
    }
    
    public func saveChangesAsync(_ completion: @escaping ((_ saved: Bool) -> Void)) {
        completion(self.saveChanges())
    }
    public func saveChangesAsync(item: TEntity?, _ completion: @escaping ((_ saved: Bool) -> Void)) {
        completion(self.saveChanges(item: item))
    }
    public func saveChangesAsync(items: Set<TEntity>, _ completion: @escaping ((_ saved: Bool) -> Void)) {
        completion(self.saveChanges(items: items))
    }
}
