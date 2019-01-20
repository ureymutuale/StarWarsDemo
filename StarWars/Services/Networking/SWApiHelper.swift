//
//  SWApiHelper.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

public struct SWPaging {
    public var page: Int
    public var limit: Int
    public init(page: Int, limit: Int) {
        self.page = page
        self.limit = limit
    }
    var description: String {
        return "Page: \(page) Limit: \(limit)"
    }
}

public struct SWFilter {
    public fileprivate(set) var customArguments: [(key: String, value: Any)] = [(key: String, value: Any)]()
    var description: String {
        var descriptionText = ""
        for param in customArguments {
            descriptionText += "\(param.key): \(param.value)\t"
        }
        return "\(descriptionText)"
    }
    public init() {
    }
    public init(key: String, value: Any) {
        self.customArguments.append((key, value))
    }
    public init(offset: Int, limit: Int) {
        self.customArguments.append(("offset", offset as Any))
        self.customArguments.append(("per_page", limit as Any))
    }
    public mutating func addArgument(_ key: String, value: Any) {
        self.customArguments.append((key, value))
    }
}

extension SWNetworkClientService {
    class func parseRequestResponse(response: Any?, key: String?) -> (response: Any?, message: String) {
        var responseMessage: String = "success"
        var jsonResponse: Any?
        if let jsonArray = response as? [Any] {
            jsonResponse = jsonArray
        }
        if let json = response as? [String: Any] {
            jsonResponse = json
            if let key = key, let dataArray = json[key] as? [Any] {
                jsonResponse = dataArray
            }
            if let errorMsg = json["error-code"] as? String { //Has Error Message
                responseMessage = errorMsg
            }
            if let errorMsg = json["error-message"] as? String { //Has Error Message
                responseMessage = errorMsg
            }
            if let errorMsg = json["message"] as? String { //Has Error Message
                responseMessage = errorMsg
            }
            if let errorMsg = json["systemMessage"] as? String { //Has Error Message
                responseMessage = errorMsg
            }
            if let errorMsg = json["data"] as? String { //Has Error Message
                responseMessage = errorMsg
            }
        }
        return (jsonResponse, responseMessage)
    }
}
