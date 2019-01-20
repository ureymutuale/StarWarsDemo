//
//  SWFilmHelper.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWFilmHelper: SWIHelper  {
    static var creationDispatchGroup: DispatchGroup = DispatchGroup()
    static var creationQueue: DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
    
    class func itemsFromDict(_ dict: Any?) -> (items: [SWFilm], updated: Bool) {
        var items: [SWFilm] = [SWFilm]()
        var updated = false
        let semaphore = DispatchSemaphore(value: 0)
       NSLog("[\(NSStringFromClass(self))]: START ALL ITEMS")
        if let listArray = dict as? [[String: Any]] {
            let itemsListArray: [[String: Any]] = listArray
            let itemsDispatchGroup = self.creationDispatchGroup
            let itemsCreationQueue = self.creationQueue
            for itemDict in itemsListArray {
                itemsDispatchGroup.enter()
                var item: SWFilm?
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
                if let setItems = NSOrderedSet(array: items).array as? [SWFilm] {
                    items = setItems
                }
                semaphore.signal()
            })
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        }
        NSLog("[\(NSStringFromClass(self))]: FINISHED ALL ITEMS -> \(items.count)")
        return (items, updated)
    }
    class func itemsFromDictAsync(_ dict: Any?, _ completion: @escaping (([SWFilm], Bool) -> Void)) {
        let result = self.itemsFromDict(dict)
        completion(result.items, result.updated)
    }
    
    class func itemFromDict(_ dict: Any?, oldItem: SWFilm?) -> (item: SWFilm?, updated: Bool) {
        var item: SWFilm?
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
            item = SWFilm()
            item?.id = itemID
            item?.url = itemUrl
            if let episodeId = itemDict["episode_id"] as? NSNumber {
                item?.episodeId = episodeId
            }
            if let title = itemDict["title"] as? String {
                item?.title = title
            }
            if let openingCrawl = itemDict["opening_crawl"] as? String {
                item?.openingCrawl = openingCrawl
            }
            if let director = itemDict["director"] as? String {
                item?.director = director
            }
            if let producer = itemDict["producer"] as? String {
                item?.producer = producer
            }
            
            //Create Characters
            var charactersArrayDict: [[String: Any]] = []
            if let charactersArray = itemDict["characters"] as? [String] {
                for url in charactersArray {
                    var characterDict: [String: Any] = [:]
                    //characterDict.updateValue(key, forKey: "id")
                    characterDict.updateValue(url, forKey: "url")
                    charactersArrayDict.append(characterDict)
                }
            }
            let characters = SWCharacterHelper.itemsFromDict(charactersArrayDict).items
            if charactersArrayDict.count > 0 {
                _ = item?.addCharacters(Set(characters), clean: true)
            }
            
            var formatter = SWDateFormatter.simpleDateFormatter
            if let dateString = itemDict["release_date"] as? String, let releaseDateString = dateString.components(separatedBy: "+00:00").first {
                item?.releaseDate = formatter.date(from: releaseDateString)
            }
            formatter = SWDateFormatter.fullDateTimeFormatter
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
    class func itemFromDictAsync(_ dict: Any?, oldItem: SWFilm?, _ completion: @escaping ((SWFilm?, Bool) -> Void)) {
        let result = self.itemFromDict(dict, oldItem: oldItem)
        completion(result.item, result.updated)
    }
}
