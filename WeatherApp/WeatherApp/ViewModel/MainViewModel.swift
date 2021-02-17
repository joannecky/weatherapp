//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class MainViewModel: NSObject{
    
    var weather: CurrentWeather?
    
    override init() {
        super.init()
        setup()
    }
    
    func setup(){
        if let location = UserDefaults.getLocationList().first, let lat = location.lat, let lon = location.lon{
            CurrentWeatherService.shared.getCurrentWeatherByCoordinates(lat: String(lat), lon: String(lon)){ (success, result, error, errorMessage, statusCode) in
                self.weather = result
            }
        }
    }
}
