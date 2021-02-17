//
//  SavedDisplayModel.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class SavedDisplayModel: NSObject{
    var icon: String
    var city: String
    var temp: Double
    
    init(icon: String, city: String, temp: Double){
        self.icon = icon
        self.city = city
        self.temp = temp
    }
}
