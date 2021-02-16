//
//  Main.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class Main: NSObject{
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max : Double?
    var pressure : Int?
    var humidity : Int?

    init(dictionary:[String : Any]){
        if let temp = dictionary["temp"] as? Double{
            self.temp = temp
        }
        if let feels_like = dictionary["feels_like"] as? Double{
            self.feels_like = feels_like
        }
        if let temp_min = dictionary["temp_min"] as? Double{
            self.temp_min = temp_min
        }
        if let temp_max = dictionary["temp_max"] as? Double{
            self.temp_max = temp_max
        }
        if let pressure = dictionary["pressure"] as? Int{
            self.pressure = pressure
        }
        if let humidity = dictionary["humidity"] as? Int{
            self.humidity = humidity
        }
    }
}
