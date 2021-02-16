//
//  Coordinate.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class Coordinate: NSObject{
    var lon: Double?
    var lat: Double?
    
    init(dictionary:[String : Any]){
        if let lon = dictionary["lon"] as? Double{
            self.lon = lon
        }
        if let lat = dictionary["lat"] as? Double{
            self.lat = lat
        }
    }
}
