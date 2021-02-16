//
//  OpenWeatherMapManager.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

//enum openWeatherMapApi{
//    case
//    case currentWeatherByZipCode
//    case currentWeatherByCoordinates
//}

class OpenWeatherManager: NSObject {

    public static let shared = OpenWeatherMapManager()
    public static let apiKey = "95d190a434083879a6398aafd54d9e73"

    public func getCurrentWeatherByCityName(cityName: String, completion: @escaping (_ success:Bool, _ result: CurrentWeather?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(OpenWeatherMapManager.apiKey)"
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
                let currentWeather = CurrentWeather(dictionary: responseObject)
                completion(true, currentWeather, nil, "", -1)
            }
        }
        task.resume()
    }
}
