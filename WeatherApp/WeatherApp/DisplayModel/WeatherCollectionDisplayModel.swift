//
//  WeatherCollectionDisplayModel.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

enum WeatherCollectionDisplayModelPosition{
    case first
    case middle
    case last
    case only
}

class WeatherCollectionDisplayModel: NSObject {
    var title: String
    var desc: String
    var unit: String
    var remark: String
    var position: WeatherCollectionDisplayModelPosition = .middle

    init(title: String, desc: String, unit: String, remark: String){
        self.title = title
        self.desc = desc
        self.unit = unit
        self.remark = remark
    }
}
