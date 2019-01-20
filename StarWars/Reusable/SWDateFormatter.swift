//
//  SWDateFormatter.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWDateFormatter: NSObject {
    static let sharedDateFormatter: SWDateFormatter = {
        let instance = SWDateFormatter()
        return instance
    }()
    
    fileprivate var dateFormatter: DateFormatter!
    
    override init() {
        super.init()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd MMMM YYYY"
        self.dateFormatter.locale = Locale.autoupdatingCurrent
        self.dateFormatter.timeZone = TimeZone.current
    }
    
    class var simpleDateFormatter: DateFormatter {
        sharedDateFormatter.dateFormatter.dateFormat = "YYYY-MM-dd"
        return sharedDateFormatter.dateFormatter
    }
    
    class var fullDateTimeFormatter: DateFormatter {
        sharedDateFormatter.dateFormatter.dateFormat = "dd MMMM YYYY"
        return sharedDateFormatter.dateFormatter
    }
}
