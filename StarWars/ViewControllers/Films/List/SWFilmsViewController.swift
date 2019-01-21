//
//  SWFilmsViewController.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

enum SWFilmSorting: String {
    case `default`
    case ascendingTitle
    case descendingTitle
    case ascendingReleaseDate
    case descendingReleaseDate
}

class SWFilmsViewController: SWViewController {

    @IBOutlet fileprivate(set) weak var filmsTableView: UITableView!
    fileprivate(set) var refreshControl: UIRefreshControl!
    
    fileprivate(set) var allFilms: [SWFilm] = []
    fileprivate(set) var filteredFilms: [SWFilm] = []
    
    fileprivate var isLoadinFilms: Bool = false
    fileprivate(set) var selectedItemsIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    fileprivate(set) var sorting: SWFilmSorting = .default
    
    lazy var filmsSearchController: SWSearchController = {
        let searchController = SWSearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.barTintColor = SWAppColor.FilmsScreen.Navigationbar.barColor
        searchController.searchBar.tintColor = SWAppColor.FilmsScreen.Navigationbar.itemTintColor
        searchController.searchBar.placeholder = "Search Films"
        searchController.searchBar.searchTextField?.backgroundColor = SWAppColor.FilmsScreen.Navigationbar.barColor.darkerBy(10)
        searchController.searchBar.searchTextField?.textColor = SWAppColor.FilmsScreen.Navigationbar.itemTintColor
        searchController.searchBar.searchTextField?.tintColor = SWAppColor.FilmsScreen.Navigationbar.itemTintColor
        searchController.searchBar.searchTextField?.clearButtonMode = UITextField.ViewMode.whileEditing
        searchController.searchBar.showsCancelButton = true
        return searchController
    }()
    
    // MARK: + Initialization  methods
    convenience init(fromNib: Bool = true) {
        if fromNib {
            self.init(nibName: "SWFilmsViewController", bundle: nil)
        } else {
            self.init(nibName: nil, bundle: nil)
        }
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    // MARK: + Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filmsSearchController.searchResultsUpdater = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.allFilms.count <= 0 {
            self.loadFilms(forceRefresh: false)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.filmsSearchController.searchResultsUpdater = nil
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SWAppColor.FilmsScreen.statusBarStyle
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSLog("\(NSStringFromClass(self.classForCoder)) didReceiveMemoryWarning")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SWAppSegue.SWFilmDetailsViewController || segue.identifier == SWAppSegue.SWFilmDetailsViewControllerReplace {
            var destinationVc: UIViewController? = segue.destination
            if let nav = destinationVc as? UINavigationController, let firstVc = nav.topViewController as? SWFilmDetailsViewController {
                destinationVc = firstVc
            }
            if let film = sender as? SWFilm, let filmDetailsVc = destinationVc as? SWFilmDetailsViewController {
                filmDetailsVc.film = film
                filmDetailsVc.view.backgroundColor = UIColor.white //Force Load View
            }
        }
    }
    
    // MARK: + View Setup methods
    override func loadSubviews() {
        super.loadSubviews()
        self.filmsTableView.register(SWAppCell.SWFilmTableViewCell.1, forCellReuseIdentifier: SWAppCell.SWFilmTableViewCell.0)
        self.filmsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.filmsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.filmsTableView.delegate = self
        self.filmsTableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = SWAppColor.FilmsScreen.refreshControlTintColor
        
        let attributedString = NSMutableAttributedString(string: "Pull to refresh")
        attributedString.addAttribute(NSAttributedString.Key.font, value: SWAppFont.FilmsScreen.refreshControlFont, range: NSRange(location: 0, length: attributedString.string.count))
        self.refreshControl.attributedTitle = attributedString
        self.refreshControl.addTarget(self, action: #selector(self.refreshFilmsList(_:)), for: UIControl.Event.valueChanged)
        self.filmsTableView.addSubview(self.refreshControl)
    }
    override func setupSubviewsLayout() {
        super.setupSubviewsLayout()
    }
    override func applySubviewsAppearance() {
        super.applySubviewsAppearance()
        self.view.backgroundColor = SWAppColor.FilmsScreen.backgroundColor
        self.navigationController?.setupNavigationControllerWithBarColor(barColor: SWAppColor.FilmsScreen.Navigationbar.barColor, tintColor: SWAppColor.FilmsScreen.Navigationbar.itemTintColor, titleColor: SWAppColor.FilmsScreen.Navigationbar.titleColor, titleFont: SWAppFont.FilmsScreen.Navigationbar.titleFont, hidden: false)
        self.navigationController?.setBottomBorderColor(SWAppColor.FilmsScreen.Navigationbar.borderColor, height: 0.2)
        self.setupNavigationBarItems()
    }
    override func forceViewReload() {
        super.forceViewReload()
    }
    
    // MARK: + Private methods
    fileprivate func setupNavigationBarItems() {
        var navigationItem: UINavigationItem? = self.navigationItem
        if let navItem = self.splitViewController?.navigationItem {
            //navigationItem = navItem
        }
        navigationItem?.title = "Films"
        //Search
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.searchBarButtonItemPressed(_:)))
        //Sorting
        let sortingBarButton = UINavigationController.barButtonItemWithImage(UIImage(named: "icon_sort"), color: SWAppColor.FilmsScreen.Navigationbar.itemTintColor, selectedColor: SWAppColor.FilmsScreen.Navigationbar.highlightedItemTintColor, size: CGSize(width: 30, height: 30), target: self, action: #selector(self.sortBarButtonItemPressed(_:)))
        navigationItem?.rightBarButtonItems = [sortingBarButton, searchBarButtonItem]
    }
    fileprivate func loadFilms(forceRefresh: Bool = false) {
        let paging = SWPaging(page: 1, limit: 10)
        if self.isLoadinFilms {
            return
        }
        SWLoadingController.default.showLoadingInView(nil, id: "FilmsList")
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: {
            self.isLoadinFilms = true
            SWFilmApiClient.default.fetchFilmsWithPaging(paging, filter: nil) { (films, success, message) in
                let isLocal = false
                NSLog("FETCH - FILMS: \(paging)) FILMS: \(films.count) UPDATED: \(success) LOCAL: \(isLocal) MSG: \(message)")
                if success || !isLocal || (isLocal && self.allFilms.count <= 0) || forceRefresh {
                    self.allFilms = films
                    self.sorting = .default
                    self.reloadTableViewContent()
                }
                if !isLocal {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.refreshControl.endRefreshing()
                    })
                }
                self.isLoadinFilms = false
                SWLoadingController.default.hideLoadingFromView(nil, id: "FilmsList")
            }
        })
    }
    fileprivate func reloadTableViewContent() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.filteredFilms = self.sortFilms(self.allFilms, sorting: self.sorting)
            self.filmsTableView.reloadData()
            if let _ = self.splitViewController {
                self.selectFilmAtIndexPath(self.selectedItemsIndexPath)
            }
        })
    }
    fileprivate func sortFilms(_ films: [SWFilm], sorting: SWFilmSorting = .default) -> [SWFilm] {
        var sortedFilms = films
        switch sorting {
        case .ascendingTitle:
            sortedFilms = films.sorted(by: { (film1, film2) -> Bool in
                if let title1 = film1.title, let title2 = film2.title {
                    return title1 < title2
                }
                return false
            })
        case .descendingTitle:
            sortedFilms = films.sorted(by: { (film1, film2) -> Bool in
                if let title1 = film1.title, let title2 = film2.title {
                    return title1 > title2
                }
                return false
            })
        case .ascendingReleaseDate:
            sortedFilms = films.sorted(by: { (film1, film2) -> Bool in
                if let date1 = film1.releaseDate, let date2 = film2.releaseDate {
                    return date1 < date2
                }
                return false
            })
        case .descendingReleaseDate:
            sortedFilms = films.sorted(by: { (film1, film2) -> Bool in
                if let date1 = film1.releaseDate, let date2 = film2.releaseDate {
                    return date1 > date2
                }
                return false
            })
        default:
            break
        }
        return sortedFilms
    }
    fileprivate func selectFilmAtIndexPath(_ indexPath: IndexPath) {
        self.filmsSearchController.isActive = false
        var selected = false
        var film: SWFilm?
        if indexPath.row < self.filteredFilms.count {
            film = self.filteredFilms[indexPath.row]
        }
        //Deselect
        if let cell = self.filmsTableView.cellForRow(at: self.selectedItemsIndexPath) as? SWFilmTableViewCell {
            cell.isCellSelected = false
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        if let film = film {
            self.selectedItemsIndexPath = indexPath
            selected = true
        }
        //Select
        if let cell = self.filmsTableView.cellForRow(at: self.selectedItemsIndexPath) as? SWFilmTableViewCell {
            cell.isCellSelected = selected
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        let segueId = self.splitViewController != nil ? SWAppSegue.SWFilmDetailsViewControllerReplace : SWAppSegue.SWFilmDetailsViewController
        self.performSegue(withIdentifier: segueId, sender: film)
    }
    
    
    // MARK: + Action methods
    @IBAction func dismissCurrentViewController(_ sender: Any) {
        if self.isPushed() {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func refreshFilmsList(_ sender: Any) {
        self.loadFilms(forceRefresh: true)
    }
    @IBAction func searchBarButtonItemPressed(_ sender: Any) {
        let navigationController = self.navigationController
        navigationController?.definesPresentationContext = true
        if !self.filmsSearchController.isActive {
            navigationController?.present(self.filmsSearchController, animated: true, completion: nil)
        }
    }
    @IBAction func sortBarButtonItemPressed(_ sender: Any) {
        let sortingAlertController = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        //Default
        let defaultSortAction = UIAlertAction(title: "Default \(self.sorting == SWFilmSorting.default ? "✔" : "")", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.sorting = SWFilmSorting.default
            self.reloadTableViewContent()
        })
        sortingAlertController.addAction(defaultSortAction)
        //Title
        let titleAscSortAction = UIAlertAction(title: "Ascending Title \(self.sorting == SWFilmSorting.ascendingTitle ? "✔" : "")", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.sorting = SWFilmSorting.ascendingTitle
            self.reloadTableViewContent()
        })
        sortingAlertController.addAction(titleAscSortAction)
        let titleDescSortAction = UIAlertAction(title: "Descending Title \(self.sorting == SWFilmSorting.descendingTitle ? "✔" : "")", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.sorting = SWFilmSorting.descendingTitle
            self.reloadTableViewContent()
        })
        sortingAlertController.addAction(titleDescSortAction)
        //Release Date
        let releaseDateAscSortAction = UIAlertAction(title: "Ascending Release Date \(self.sorting == SWFilmSorting.ascendingReleaseDate ? "✔" : "")", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.sorting = SWFilmSorting.ascendingReleaseDate
            self.reloadTableViewContent()
        })
        sortingAlertController.addAction(releaseDateAscSortAction)
        let releaseDateDescSortAction = UIAlertAction(title: "Descending Release Date \(self.sorting == SWFilmSorting.descendingReleaseDate ? "✔" : "")", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.sorting = SWFilmSorting.descendingReleaseDate
            self.reloadTableViewContent()
        })
        sortingAlertController.addAction(releaseDateDescSortAction)
        
        if sortingAlertController.actions.count > 0 {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction!) -> Void in
                sortingAlertController.dismiss(animated: true, completion: nil)
            })
            sortingAlertController.addAction(cancelAction)
            
            sortingAlertController.popoverPresentationController?.sourceView = self.filmsTableView
            sortingAlertController.popoverPresentationController?.sourceRect = self.filmsTableView.bounds
            if let barButton = sender as? UIBarButtonItem {
                sortingAlertController.popoverPresentationController?.barButtonItem = barButton
            }
            sortingAlertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
            self.present(sortingAlertController, animated: true, completion: nil)
        }
    }
    
    // MARK: + UIKeyboard notifications methods
    override func keyboardWillChangeFrame(_ notification: Notification) {
        super.keyboardWillChangeFrame(notification)
        var offset: CGFloat = 20
        if self.filmsSearchController.isActive, self.isKeyboardVisible, let keyboardFrame = self.keyboardFrame {
            offset = keyboardFrame.size.height
        }
        self.filmsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
    }

}

// MARK: - Location Search methods -
extension SWFilmsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let term = searchController.searchBar.text else { return }
        let searchTerm = term.trimmingCharacters(in: CharacterSet.whitespaces)
//        NSLog("Search For '\(searchTerm)' \(self.filmsSearchController.isActive)")
        var matchingFilms = self.allFilms
        if self.filmsSearchController.isActive && searchTerm.count > 0 {
            matchingFilms = matchingFilms.filter({ (film) -> Bool in
                var title = ""
                var intro = ""
                var producer = ""
                var director = ""
                if let _title = film.title {
                    title = _title
                }
                if let _intro = film.openingCrawl {
                    intro = _intro
                }
                if let _producer = film.producer {
                    producer = _producer
                }
                if let _director = film.director {
                    director = _director
                }
                return title.lowercased().contains(searchTerm.lowercased())
//                || searchTerm.count > 2 && intro.lowercased().contains(searchTerm.lowercased())
//                || searchTerm.count > 2 && producer.lowercased().contains(searchTerm.lowercased())
//                || searchTerm.count > 2 && director.lowercased().contains(searchTerm.lowercased())
            })
        }
        self.filteredFilms = matchingFilms
        self.filmsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource methods -
extension SWFilmsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredFilms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SWAppCell.SWFilmTableViewCell.0, for: indexPath)
        var film: SWFilm?
        if indexPath.row < self.filteredFilms.count {
            film = self.filteredFilms[indexPath.row]
        }
        if let filmCell = cell as? SWFilmTableViewCell {
            filmCell.loadFilm(film: film, indexPath: indexPath, selected: self.selectedItemsIndexPath == indexPath)
        }
        return cell
    }
}
// MARK: - Table view delegates methods -
extension SWFilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectFilmAtIndexPath(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight: CGFloat = 70
        return cellHeight
    }
}
