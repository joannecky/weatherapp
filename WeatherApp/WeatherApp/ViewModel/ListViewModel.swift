//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class ListViewModel: NSObject{
    var city: String
    var temp: Double
    var icon: String
    
    init(city: String, temp: Double, icon: String){
        self.city = city
        self.temp = temp
        self.icon = icon
    }
}
