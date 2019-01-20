//
//  SWRepositoryObserver.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

public let SWRepositoryInsertNotification = Notification.Name(rawValue: "SWRepositoryInsertNotification")
public let SWRepositoryUpdateNotification = Notification.Name(rawValue: "SWRepositoryUpdateNotification")
public let SWRepositoryDeleteNotification = Notification.Name(rawValue: "SWRepositoryDeleteNotification")
public let SWRepositorySaveNotification = Notification.Name(rawValue: "SWRepositorySaveNotification")

public class SWRepositoryObserver {
    
    class func postRepository<Repo: SWIRepository, Entity: SWIEntity>(repo: Repo?, hasInsertedObject object: Entity?) {
        let classR: AnyClass = Repo.self as? AnyClass ?? self
        if let object = object {
            NSLog("REPO [\(NSStringFromClass(classR))]: hasInsertedObject: \(String(describing: object))")
            DispatchQueue.main.async(execute: {
                NotificationCenter.default.post(name: SWRepositoryInsertNotification, object: repo, userInfo: (["object": object]))
            })
        }
    }
    class func postRepository<Repo: SWIRepository, Entity: SWIEntity>(repo: Repo?, hasUpdatedObject object: Entity?) {
        let classR: AnyClass = Repo.self as? AnyClass ?? self
        if let object = object {
            NSLog("REPO [\(NSStringFromClass(classR))]: hasUpdatedObject: \(String(describing: object))")
            DispatchQueue.main.async(execute: {
                NotificationCenter.default.post(name: SWRepositoryUpdateNotification, object: repo, userInfo: (["object": object]))
            })
        }
    }
    class func postRepository<Repo: SWIRepository, Entity: SWIEntity>(repo: Repo?, hasDeletedObject object: Entity?) {
        let classR: AnyClass = Repo.self as? AnyClass ?? self
        if let object = object {
            NSLog("REPO [\(NSStringFromClass(classR))]: hasDeletedObject: \(String(describing: object))")
            DispatchQueue.main.async(execute: {
                NotificationCenter.default.post(name: SWRepositoryDeleteNotification, object: repo, userInfo: (["object": object]))
            })
        }
    }
    class func postRepository<Repo: SWIRepository, Entity: SWIEntity>(repo: Repo?, hasSavedObject object: Entity?) {
        let classR: AnyClass = Repo.self as? AnyClass ?? self
        if let object = object {
            NSLog("REPO [\(NSStringFromClass(classR))]: hasSavedObject: \(String(describing: object))")
            DispatchQueue.main.async(execute: {
                NotificationCenter.default.post(name: SWRepositorySaveNotification, object: repo, userInfo: (["object": object]))
            })
        }
    }
}
