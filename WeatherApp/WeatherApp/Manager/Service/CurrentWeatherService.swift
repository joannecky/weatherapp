//
//  CurrentWeatherService.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class CurrentWeatherService: NSObject {

    public static let shared = CurrentWeatherService()
    public static let apiKey = "95d190a434083879a6398aafd54d9e73"

    // MARK: - Current Weather
    public func getCurrentWeatherByCityName(cityName: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(OpenWeatherManager.apiKey)&units=metric"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                completion(success, CurrentWeather(dictionary: r), error, errorMessage, statusCode)
            }else{
                completion(success, nil, error, errorMessage, statusCode)
            }
        }
    }
    
    public func getCurrentWeatherByZipCode(zipCode: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(zipCode),us&appid=\(OpenWeatherManager.apiKey)&units=metric"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                completion(success, CurrentWeather(dictionary: r), error, errorMessage, statusCode)
            }else{
                completion(success, nil, error, errorMessage, statusCode)
            }
        }
    }
    
    public func getCurrentWeatherByCoordinates(lat: String, lon: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OpenWeatherManager.apiKey)&units=metric"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode)
            in
            if result != nil, let r = result{
                completion(success, CurrentWeather(dictionary: r), error, errorMessage, statusCode)
            }else{
                completion(success, nil, error, errorMessage, statusCode)
            }
        }
    }
}
