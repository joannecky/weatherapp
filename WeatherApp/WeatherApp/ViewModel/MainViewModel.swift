//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainViewModelDelegate {
    func reload()
}

class MainViewModel: NSObject{
    
    var weather: CurrentWeather?
    var location: Geocoding?
    var list: [WeatherCollectionDisplayModel]?
    var delegate: MainViewModelDelegate?

    override init() {
        super.init()
        setup()
    }
    
    func setup(){
        if let location = UserDefaults.getLocationList().first{
            display(location: location)
        }
    }
    
    func display(location: Geocoding){
        CurrentWeatherService.shared.getCurrentWeatherByCityName(cityName: location.fullName()){ (success, result, error, errorMessage, statusCode) in
            self.location = location
            self.weather = result
            var list:[WeatherCollectionDisplayModel] = []
            if let speed = self.weather?.wind?.speed{
                list.append(WeatherCollectionDisplayModel(title: "Wind", desc: String(round(speed/1000*60*60*10)/10), unit: "km/h", remark: ""))
            }
            if let humidity = self.weather?.main?.humidity{
                list.append(WeatherCollectionDisplayModel(title: "Humidity", desc: String(humidity), unit: "%", remark: ""))
            }
            if let rain = self.weather?.rain?.hr1{
                list.append(WeatherCollectionDisplayModel(title: "Rain", desc: String(round(rain*10)/10), unit: "mm/h", remark: ""))
            }
            if list.count == 1{
                list.first?.position = .only
            }else if list.count > 1{
                list.first?.position = .first
                list.last?.position = .last
            }
            self.list = list
            self.delegate?.reload()
        }
    }
}
