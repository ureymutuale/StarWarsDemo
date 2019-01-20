//
//  SWCharacterHelper.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWCharacterHelper: SWIHelper  {
    static var creationDispatchGroup: DispatchGroup = DispatchGroup()
    static var creationQueue: DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
    
    class func itemsFromDict(_ dict: Any?) -> (items: [SWCharacter], updated: Bool) {
        var items: [SWCharacter] = [SWCharacter]()
        var updated = false
        let semaphore = DispatchSemaphore(value: 0)
        NSLog("[\(NSStringFromClass(self))]: START ALL ITEMS")
        if let listArray = dict as? [[String: Any]] {
            let itemsListArray: [[String: Any]] = listArray
            let itemsDispatchGroup = self.creationDispatchGroup
            let itemsCreationQueue = self.creationQueue
            for itemDict in itemsListArray {
                itemsDispatchGroup.enter()
                var item: SWCharacter?
                let result = self.itemFromDict(itemDict, oldItem: nil)
                item = result.item
                if item != nil {
                    items.append(item!)
                }
                if !updated {
                    updated = result.updated
                }
                itemsDispatchGroup.leave()
            }
            if itemsListArray.count <= 0 {
                itemsDispatchGroup.enter()
                itemsDispatchGroup.leave()
            }
            itemsDispatchGroup.notify(queue: itemsCreationQueue, execute: {
                if let setItems = NSOrderedSet(array: items).array as? [SWCharacter] {
                    items = setItems
                }
                semaphore.signal()
            })
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        }
        NSLog("[\(NSStringFromClass(self))]: FINISHED ALL ITEMS -> \(items.count)")
        return (items, updated)
    }
    class func itemsFromDictAsync(_ dict: Any?, _ completion: @escaping (([SWCharacter], Bool) -> Void)) {
        let result = self.itemsFromDict(dict)
        completion(result.items, result.updated)
    }
    
    class func itemFromDict(_ dict: Any?, oldItem: SWCharacter?) -> (item: SWCharacter?, updated: Bool) {
        var item: SWCharacter?
        var updated = false
        if let itemDict = dict as? [String: Any] {
            var itemID: NSNumber?
            var itemUrl: String?
            if let id = itemDict["id"] as? NSNumber {
                itemID = id
            }
            if let url = itemDict["url"] as? String {
                itemUrl = url
            }
            if itemUrl == nil {
                return (item: item, updated: updated)
            }
            updated = true
            item = SWCharacter()
            item?.id = itemID
            item?.url = itemUrl
            if let name = itemDict["name"] as? String {
                item?.name = name
            }
            if let height = itemDict["height"] as? NSNumber {
                item?.height = height.doubleValue
            }
            if let mass = itemDict["mass"] as? NSNumber {
                item?.mass = mass.doubleValue
            }
            if let hairColor = itemDict["hair_color"] as? String {
                item?.hairColor = hairColor
            }
            if let skinColor = itemDict["skin_color"] as? String {
                item?.skinColor = skinColor
            }
            if let eyeColor = itemDict["eye_color"] as? String {
                item?.eyeColor = eyeColor
            }
            if let birthYear = itemDict["birth_year"] as? String {
                item?.birthYear = birthYear
            }
            if let gender = itemDict["gender"] as? String {
                item?.gender = gender
            }
            
            //Create Films
            /*var filmsArrayDict: [[String: Any]] = []
            if let filmsArray = itemDict["films"] as? [String] {
                for url in filmsArray {
                    var filmDict: [String: Any] = [:]
                    //filmDict.updateValue(key, forKey: "id")
                    filmDict.updateValue(url, forKey: "url")
                    filmsArrayDict.append(filmDict)
                }
            }
            let films = SWFilmHelper.itemsFromDict(filmsArrayDict).items
            if filmsArrayDict.count > 0 {
                _ = item?.addFilms(Set(films), clean: true)
            }*/
            
            let formatter = SWDateFormatter.fullDateTimeFormatter
            if let dateString = itemDict["created"] as? String, let pubishedDateString = dateString.components(separatedBy: "+00:00").first {
                item?.createdDate = formatter.date(from: pubishedDateString)
            }
            if let dateString = itemDict["edited"] as? String, let modifiedDateString = dateString.components(separatedBy: "+00:00").first {
                item?.editedDate = formatter.date(from: modifiedDateString)
            }
            item?.isRemoved = false
        }
        NSLog("[\(NSStringFromClass(self))]: NEW ITEM -> ID: \(String(describing: item?.url))")
        return (item: item, updated: updated)
    }
    class func itemFromDictAsync(_ dict: Any?, oldItem: SWCharacter?, _ completion: @escaping ((SWCharacter?, Bool) -> Void)) {
        let result = self.itemFromDict(dict, oldItem: oldItem)
        completion(result.item, result.updated)
    }
}
