//
//  SWFilmApiClient.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
import Alamofire

class SWFilmApiClient: SWNetworkClientService {

    override class var `default`: SWFilmApiClient {
        struct Instance { static let sharedInstance = SWFilmApiClient() }
        return Instance.sharedInstance
    }
    
    // MARK: - Initialization  methods
    override init() {
        super.init()
    }
    
    // MARK: - Config  methods
    override func configureService(force: Bool = false) -> Bool {
        return super.configureService(force: force)
    }
    override func checkServiceConfiguration() -> Bool {
        return super.checkServiceConfiguration()
    }
    
    // MARK: - Films  methods
    func fetchFilmsWithPaging(_ paging: SWPaging, filter: SWFilter?, completion:((_ films: [SWFilm], _ success: Bool, _ message: String) -> Void)?) {
        if !self.checkServiceConfiguration() {
            completion?([], false, "\(NSStringFromClass(self.classForCoder)) not setup correctly")
            return
        }
        let requestHeaders: [String: String]? = [:]
        var requestParams: [String: Any] = [String: Any]()
        var jsonResponse: Any?
        var responseMessage: String = "success"
        var success = false
        let requestURLString: String = "https://swapi.co/api/films/"
        var request: DataRequest?
        guard let requestURL = URL(string: requestURLString), requestURL.isValidWebURL else {
            completion?([], false, "\(NSStringFromClass(self.classForCoder)) Invalid Request URL")
            return
        }
        //Build URL
        //RequestOperation
        let operation: BlockOperation = BlockOperation {
            //Set Params
            requestParams.updateValue(paging.limit, forKey: "per_page")
            requestParams.updateValue(paging.page <= 0 ? 1 : paging.page, forKey: "page")
            if let filter = filter {
                for param in filter.customArguments {
                    requestParams.updateValue(param.value, forKey: param.key)
                }
            }
            //Create Request
            request = self.sessionManager.request(requestURLString, method: HTTPMethod.get, parameters: requestParams, encoding: URLEncoding.default, headers: requestHeaders)
            NSLog("URL: \(String(describing: request?.request?.url))")
            request?.responseJSON(completionHandler: { (requestResponse) -> Void in
                NSLog("ALL FILMS [\(paging)]/[\(String(describing: filter))] REQUEST RESPONSE: \(requestResponse)")
                var items: [SWFilm] = []
                switch requestResponse.result {
                case .success:
                    success = true
                    let response = SWNetworkClientService.parseRequestResponse(response: requestResponse.result.value, key: "results")
                    jsonResponse = response.response
                    responseMessage = response.message
                    //Parse Data
                    let results = SWFilmHelper.itemsFromDict(response.response)
                    items = results.items
                case .failure(let error):
                    responseMessage = "Films Fetch All Request Failed"
                    NSLog("Error: \(error)")
                }
                _ = self.dequeueRequestWithURL(requestURLString: requestURLString)
                completion?(items, !self.hasErrorCode(jsonResponse) && success, responseMessage)
            })
        }
        operation.name = "\(NSStringFromClass(self.classForCoder)) Films [\(paging)]/[\(String(describing: filter))] Request"
        let newRequest = SWNetworkRequest(urlString: requestURLString, operation: operation, request: request)
        if self.enqueueRequest(newRequest: newRequest) {
            self.requestQueue.addOperation(operation)
        } else {
            responseMessage = "Request already made"
            completion?([], false, responseMessage)
        }
    }
    func fetchDetailsForFilm(_ film: SWFilm?, filter: SWFilter?, completion:((_ film: SWFilm?, _ success: Bool, _ message: String) -> Void)?) {
        if !self.checkServiceConfiguration() {
            completion?(film, false, "\(NSStringFromClass(self.classForCoder)) not setup correctly")
            return
        }
        guard let film = film else {
                completion?(nil, false, "Invalid Film")
                return
        }
        let requestHeaders: [String: String]? = [:]
        var requestParams: [String: Any] = [String: Any]()
        var jsonResponse: Any?
        var responseMessage: String = "success"
        var success = false
        var requestURLString: String = ""
        if let url = film.url {
            requestURLString = url
        } else if let id = film.id {
            requestURLString = "https://swapi.co/api/films/\(id)"
        }
        var request: DataRequest?
        guard let requestURL = URL(string: requestURLString), requestURL.isValidWebURL else {
            completion?(nil, false, "\(NSStringFromClass(self.classForCoder)) Invalid Request URL")
            return
        }
        //Build URL
        //RequestOperation
        let operation: BlockOperation = BlockOperation {
            //Set Params
            if let filter = filter {
                for param in filter.customArguments {
                    requestParams.updateValue(param.value, forKey: param.key)
                }
            }
            //Create Request
            request = self.sessionManager.request(requestURLString, method: HTTPMethod.get, parameters: requestParams, encoding: URLEncoding.default, headers: requestHeaders)
            NSLog("URL: \(String(describing: request?.request?.url))")
            request?.responseJSON(completionHandler: { (requestResponse) -> Void in
                NSLog("FILM [\(String(describing: film.id))/\(String(describing: film.url))] REQUEST RESPONSE: \(requestResponse)")
                var item: SWFilm?
                switch requestResponse.result {
                case .success:
                    success = true
                    let response = SWNetworkClientService.parseRequestResponse(response: requestResponse.result.value, key: nil)
                    jsonResponse = response.response
                    responseMessage = response.message
                    //Parse Data
                    let results = SWFilmHelper.itemFromDict(response.response, oldItem: nil)
                    item = results.item
                case .failure(let error):
                    responseMessage = "Film Fetch One Request Failed"
                    NSLog("Error: \(error)")
                }
                _ = self.dequeueRequestWithURL(requestURLString: requestURLString)
                completion?(item, !self.hasErrorCode(jsonResponse) && success, responseMessage)
            })
        }
        operation.name = "\(NSStringFromClass(self.classForCoder)) Film [\(String(describing: film.id))/\(String(describing: film.url))] Request"
        let newRequest = SWNetworkRequest(urlString: requestURLString, operation: operation, request: request)
        if self.enqueueRequest(newRequest: newRequest) {
            self.requestQueue.addOperation(operation)
        } else {
            responseMessage = "Request already made"
            completion?(film, false, responseMessage)
        }
    }
}
