//
//  DetailViewController.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
        SWFilmApiClient.default.fetchFilmsWithPaging(SWPaging(page: 1, limit: 5), filter: nil) { (films, success, message) in
            SWFilmRepository.default.insertItemsAsync(films, { (insertedFilms) in
                
            })
        }
        
//        let film = SWFilm()
//        film.url = "https://swapi.co/api/films/2/"
//        SWFilmApiClient.default.fetchDetailsForFilm(film, filter: nil) { (film, success, message) in
//            SWFilmRepository.default.insertItemAsync(film, { (insertedFilm) in
//
//            })
//        }
//
//
//        SWCharacterApiClient.default.fetchCharactersWithPaging(SWPaging(page: 1, limit: 5), filter: nil) { (characters, success, message) in
//            SWCharacterRepository.default.insertItemsAsync(characters, { (insertedCharacters) in
//
//            })
//        }
//
//        let character = SWCharacter()
//        character.url = "https://swapi.co/api/people/2/"
//        SWCharacterApiClient.default.fetchDetailsForCharacter(character, filter: nil) { (character, success, message) in
//            SWCharacterRepository.default.insertItemAsync(character, { (insertedCharacter) in
//
//            })
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

