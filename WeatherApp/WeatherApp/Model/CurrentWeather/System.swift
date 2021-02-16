//
//  System.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class System: NSObject{
    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?

    init(dictionary:[String : Any]){
        if let type = dictionary["type"] as? Int{
            self.type = type
        }
        if let id = dictionary["id"] as? Int{
            self.id = id
        }
        if let country = dictionary["country"] as? String{
            self.country = country
        }
        if let sunrise = dictionary["sunrise"] as? Int{
            self.sunrise = sunrise
        }
        if let sunset = dictionary["sunset"] as? Int{
            self.sunset = sunset
        }
    }
}

