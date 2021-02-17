//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class CurrentWeather: NSObject{
    var coord: Coordinate?
    var weather: Weather?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Cloud?
    var rain: Rain?
    var snow: Snow?
    var dt: Int?
    var sys: System?
    var timezone:Int?
    var id: Int?
    var name: String?
    var cod: Int?
    
    init(dictionary:[String : Any]){
        if let coord = dictionary["coord"] as? [String : Any]{
            self.coord = Coordinate(dictionary: coord)
        }
        if let weather = dictionary["weather"] as? [[String : Any]], let first = weather.first{
            self.weather = Weather(dictionary: first)
        }
        if let base = dictionary["base"] as? String{
            self.base = base
        }
        if let main = dictionary["main"] as? [String : Any]{
            self.main = Main(dictionary: main)
        }
        if let visibility = dictionary["visibility"] as? Int{
            self.visibility = visibility
        }
        if let wind = dictionary["wind"] as? [String : Any]{
            self.wind = Wind(dictionary: wind)
        }
        if let clouds = dictionary["clouds"] as? [String : Any]{
            self.clouds = Cloud(dictionary: clouds)
        }
        if let rain = dictionary["rain"] as? [String : Any]{
            self.rain = Rain(dictionary: rain)
        }
        if let snow = dictionary["snow"] as? [String : Any]{
            self.snow = Snow(dictionary: snow)
        }
        if let dt = dictionary["dt"] as? Int{
            self.dt = dt
        }
        if let sys = dictionary["sys"] as? [String : Any]{
            self.sys = System(dictionary: sys)
        }
        if let timezone = dictionary["timezone"] as? Int{
            self.timezone = timezone
        }
        if let id = dictionary["id"] as? Int{
            self.id = id
        }
        if let name = dictionary["name"] as? String{
            self.name = name
        }
        if let cod = dictionary["cod"] as? Int{
            self.cod = cod
        }
    }
}
