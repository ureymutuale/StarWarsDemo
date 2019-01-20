//
//  SWCharacterRepository.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWCharacterRepository: SWEntityRepository<SWCharacter>, SWICharacterRepository {
    typealias TRepo = SWCharacterRepository
    static let `default`: SWCharacterRepository = {
        let instance = SWCharacterRepository()
        instance.initializeRepository()
        return instance
    }()
}
