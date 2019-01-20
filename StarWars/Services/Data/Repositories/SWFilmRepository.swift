//
//  SWFilmRepository.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWFilmRepository: SWEntityRepository<SWFilm>, SWIFilmRepository {
    typealias TRepo = SWFilmRepository
    static let `default`: SWFilmRepository = {
        let instance = SWFilmRepository()
        instance.initializeRepository()
        return instance
    }()
}
