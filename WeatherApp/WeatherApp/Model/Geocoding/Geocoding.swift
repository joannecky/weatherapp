//
//  Geocoding.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

@objc
class Geocoding: NSObject, Codable{
    var name: String?
    var lat: Double?
    var lon: Double?
    var country: String?
    var state: String?

    init(dictionary:[String : Any]){
        if let name = dictionary["name"] as? String{
            self.name = name
        }
        if let lat = dictionary["lat"] as? Double{
            self.lat = lat
        }
        if let lon = dictionary["lon"] as? Double{
            self.lon = lon
        }
        if let country = dictionary["country"] as? String{
            self.country = country
        }
        if let state = dictionary["state"] as? String{
            self.state = state
        }
    }
}
