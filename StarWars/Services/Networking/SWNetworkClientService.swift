//
//  SWNetworkClientService.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
import Alamofire

public class SWNetworkClientService: NSObject {
    
    public class var `default`: SWNetworkClientService {
        struct Instance { static let sharedInstance = SWNetworkClientService() }
        return Instance.sharedInstance
    }
    public internal(set) var initialized: Bool = false
    public internal(set) var configured: Bool = false
    
    public fileprivate(set) var sessionManager: SessionManager!
    public fileprivate(set) lazy var requestQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "SWNetworkClientService_operation_queue"
        queue.maxConcurrentOperationCount = 10
        return queue
    }()
    public fileprivate(set) lazy var requestDispatchGroup: DispatchGroup = {
        let group = DispatchGroup()
        return group
    }()
    public fileprivate(set) lazy var requestDispatchQueue: DispatchQueue = {
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        return queue
    }()
    public fileprivate(set) var pendingRequests: [SWNetworkRequest] = []
    
    // MARK: - Initialization  methods
    public override init() {
        super.init()
        self.initializeService()
        self.configureService(force: false)
    }
    // MARK: - Initialization  methods
    public func initializeService() {
        if !self.initialized {
            NSLog("[\(NSStringFromClass(SWNetworkClientService.self))]: INITIALIZE")
            let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            self.sessionManager = Alamofire.SessionManager(configuration: configuration)
            self.initialized = true
        }
    }
    
    // MARK: - Config  methods
    public func configureService(force: Bool = false) -> Bool {
        if !self.configured || force {
            NSLog("[\(NSStringFromClass(SWNetworkClientService.self))]: CONFIGURE WITH:")
            self.configured = true
        }
        return self.configured
    }
    public func checkServiceConfiguration() -> Bool {
        return self.configured
    }
    
    // MARK: - Helper  methods
    public func removeCache() {
        URLCache.shared.removeAllCachedResponses()
        self.sessionManager.session.configuration.urlCache = nil
    }
    public func cancelAllRequests() {
        for item in self.pendingRequests {
            if let request = item.request {
                request.cancel()
            }
            if let operation = item.operation {
                operation.cancel()
            }
        }
        self.pendingRequests = []
//        self.sessionManager.session.finishTasksAndInvalidate()
        //self.sessionManager.session.invalidateAndCancel()
        self.requestQueue.cancelAllOperations()
    }
    public func cancelRequestWithURL(_ url: URL) {
        self.cancelRequestsWithURLString(url.path)
    }
    public func cancelRequestsWithURLString(_ urlString: String) {
        for item in (self.pendingRequests.filter { $0.urlString == urlString }) {
            if let request = item.request {
                request.cancel()
            }
            if let operation = item.operation {
                operation.cancel()
            }
        }
        self.pendingRequests = (self.pendingRequests.filter { $0.urlString != urlString })
    }
    public func enqueueRequest(newRequest: SWNetworkRequest) -> Bool {
        if !(self.pendingRequests.contains { $0.urlString == newRequest.urlString }) {
            self.pendingRequests.append(newRequest)
            return true
        }
        return false
    }
    public func dequeueRequest(request: SWNetworkRequest) -> Bool {
        if (self.pendingRequests.contains { $0.urlString == request.urlString }) {
            self.pendingRequests = (self.pendingRequests.filter { $0.urlString != request.urlString })
            return true
        }
        return false
    }
    public func dequeueRequestWithURL(requestURLString: String) -> Bool {
        if (self.pendingRequests.contains { $0.urlString == requestURLString }) {
            self.pendingRequests = (self.pendingRequests.filter { $0.urlString != requestURLString })
            return true
        }
        return false
    }
}

// MARK: - Response Validation
extension SWNetworkClientService {
    public func hasErrorCode(_ response: Any?) -> Bool {
        guard let response = response else {
            return true
        }
        if let responseString = response as? String {
            if responseString.contains("<!DOCTYPE html><html>") {
                return true
            } else if responseString.contains("Error") {
                return true
            }
        }
        if let responseDict = response as? [String: Any] {
            if let _ = responseDict["error-code"] as? NSNumber {
                return true
            }
            if let _ = responseDict["code"] as? NSNumber {
                return true
            }
            if let dataDict = responseDict["data"] as? [String: Any] {
                if let _ = dataDict["status"] as? NSNumber {
                    return true
                }
            }
        }
        return false
    }
}


// MARK: - OBMNetworkRequest
public struct SWNetworkRequest {
    var urlString: String?
    var operation: Operation?
    var request: Request?
    public init(urlString: String?, operation: Operation?, request: Request?) {
        self.urlString = urlString
        self.operation = operation
        self.request = request
    }
}
