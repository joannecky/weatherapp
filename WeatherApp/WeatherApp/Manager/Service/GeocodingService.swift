//
//  GeocodingService.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class GeocodingService: NSObject {

    public static let shared = GeocodingService()

    // MARK: - Geocoding
    public func directGeocodingByCityName(input: String, completion: @escaping (_ success:Bool, _ result: [Geocoding]?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/geo/1.0/direct?q=\(input)&limit=5&lang=en&appid=\(OpenWeatherManager.apiKey)"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                if let responseObject = (try? JSONSerialization.jsonObject(with: r)) as? [[String: Any]]{
                    var list: [Geocoding] = []
                    for obj in responseObject{
                        list.append(Geocoding(dictionary: obj))
                    }
                    completion(success, list, error, errorMessage, statusCode)
                    return
                }
            }
            completion(success, nil, error, errorMessage, statusCode)
            return
        }
    }
    
    public func directGeocodingByZipCode(input: String, completion: @escaping (_ success:Bool, _ result: Geocoding?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
          let url = "http://api.openweathermap.org/geo/1.0/zip?zip=\(input)&lang=en&appid=\(OpenWeatherManager.apiKey)"
          OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
              if result != nil, let r = result{
                  if let responseObject = (try? JSONSerialization.jsonObject(with: r)) as? [String: Any]{
                      let obj = Geocoding(dictionary: responseObject)
                      completion(success, obj, error, errorMessage, statusCode)
                      return
                  }
              }
              completion(success, nil, error, errorMessage, statusCode)
              return
          }
      }
    
    public func reverseGeocodingByCoordinate(lat: String, lon: String, completion: @escaping (_ success:Bool, _ result: Geocoding?, _ error: Error?, _ errorMessage: String?, _ statusCode: Int) -> Void) {
        let url = "http://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&lang=en&appid=\(OpenWeatherManager.apiKey)"
        OpenWeatherManager.shared.callApi(url: url) { (success, result, error, errorMessage, statusCode) in
            if result != nil, let r = result{
                if let responseObject = (try? JSONSerialization.jsonObject(with: r)) as? [[String: Any]], let first = responseObject.first{
                    let obj = Geocoding(dictionary: first)
                    completion(success, obj, error, errorMessage, statusCode)
                    return
                }
            }
            completion(success, nil, error, errorMessage, statusCode)
            return
        }
    }
}
