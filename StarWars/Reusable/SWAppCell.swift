//
//  SWAppCell.swift
//  StarWars
//
//  Created by UreyMt on 1/19/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit

class SWAppCell: NSObject {
    class var  TestCell: (String, UINib) {
        return  ("TestCell", UINib(nibName: "TestCell", bundle: Bundle.main))
    }
}
