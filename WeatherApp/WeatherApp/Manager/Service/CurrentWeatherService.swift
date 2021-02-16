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

    // MARK: - Current Weather
    public func getCurrentWeatherByCityName(cityName: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(OpenWeatherManager.apiKey)&units=metric"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                if let responseObject = (try? JSONSerialization.jsonObject(with: r)) as? [String: Any]{
                    completion(success, CurrentWeather(dictionary: responseObject), error, errorMessage, statusCode)
                    return
                }
            }
            completion(success, nil, error, errorMessage, statusCode)
            return
        }
    }
    
    public func getCurrentWeatherByZipCode(zipCode: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(zipCode),us&appid=\(OpenWeatherManager.apiKey)&units=metric"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                if let responseObject = (try? JSONSerialization.jsonObject(with: r)) as? [String: Any]{
                    completion(success, CurrentWeather(dictionary: responseObject), error, errorMessage, statusCode)
                    return
                }
            }
            completion(success, nil, error, errorMessage, statusCode)
            return
        }
    }
    
    public func getCurrentWeatherByCoordinates(lat: String, lon: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OpenWeatherManager.apiKey)&units=metric"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                if let responseObject = (try? JSONSerialization.jsonObject(with: r)) as? [String: Any]{
                    completion(success, CurrentWeather(dictionary: responseObject), error, errorMessage, statusCode)
                    return
                }
            }
            completion(success, nil, error, errorMessage, statusCode)
            return
        }
    }
}
