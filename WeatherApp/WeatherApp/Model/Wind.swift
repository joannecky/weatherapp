//
//  Wind.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class Wind: NSObject{
    var speed: Double?
    var deg: Int?
    var gust: Double?
    
    init(dictionary:[String : Any]){
        if let speed = dictionary["speed"] as? Double{
            self.speed = speed
        }
        if let deg = dictionary["deg"] as? Int{
            self.deg = deg
        }
        if let gust = dictionary["gust"] as? Double{
            self.gust = gust
        }
    }
}
