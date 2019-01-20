//
//  SWRepositoryDelegate.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

// MARK: - SWRepositoryDelegate
protocol SWRepositoryDelegate: NSObjectProtocol {
    func repository<Repo: SWIRepository, Entity: SWIEntity>(_ repo: Repo?, hasInsertedObject object: Entity?)
    func repository<Repo: SWIRepository, Entity: SWIEntity>(_ repo: Repo?, hasUpdatedObject object: Entity?)
    func repository<Repo: SWIRepository, Entity: SWIEntity>(_ repo: Repo?, hasDeletedObject object: Entity?)
    func repository<Repo: SWIRepository, Entity: SWIEntity>(_ repo: Repo?, hasSavedObject object: Entity?)
}
