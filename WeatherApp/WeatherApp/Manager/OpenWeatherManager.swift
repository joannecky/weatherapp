//
//  OpenWeatherManager.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class OpenWeatherManager: NSObject {

    public static let shared = OpenWeatherManager()
    public static let apiKey = "95d190a434083879a6398aafd54d9e73"

    // MARK: - Current Weather
    public func getCurrentWeatherByCityName(cityName: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(OpenWeatherManager.apiKey)&units=metric"
        callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                completion(success, CurrentWeather(dictionary: r), error, errorMessage, statusCode)
            }else{
                completion(success, nil, error, errorMessage, statusCode)
            }
        }
    }
    
    public func getCurrentWeatherByZipCode(zipCode: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(zipCode),us&appid=\(OpenWeatherManager.apiKey)&units=metric"
        callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                completion(success, CurrentWeather(dictionary: r), error, errorMessage, statusCode)
            }else{
                completion(success, nil, error, errorMessage, statusCode)
            }
        }
    }
    
    public func getCurrentWeatherByCoordinates(lat: String, lon: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OpenWeatherManager.apiKey)&units=metric"
        callApi(url: url) { (success, result, error, errorMessage, statusCode)
            in
            if result != nil, let r = result{
                completion(success, CurrentWeather(dictionary: r), error, errorMessage, statusCode)
            }else{
                completion(success, nil, error, errorMessage, statusCode)
            }
        }
    }
    
    // MARK: - Call Api
    func callApi(url: String, completion: @escaping (_ success:Bool, _ result: [String: Any]?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                completion(false, nil, error, error?.localizedDescription, -1)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completion(false, nil, nil, "Failed in Http call, Status Code = \(httpStatus.statusCode)", httpStatus.statusCode)
                return
            }
        
            if let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]{
                completion(true, responseObject, nil, "", -1)
                return
            }
            
            completion(false, nil, nil, nil, -1)
            return
        }
        task.resume()
    }
}
