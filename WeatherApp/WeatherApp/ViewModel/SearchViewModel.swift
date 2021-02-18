//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation
import CoreLocation

protocol SearchViewModelDelegate {
    func reloadSearch(empty: Bool)
    func reloadSaved(empty: Bool)
    func display(current: Geocoding)
}

class SearchViewModel: NSObject{
    
    var saved: [SavedDisplayModel]?
    var result: [Geocoding]?
    var isSearching: Bool = false
    var delegate: SearchViewModelDelegate?
    let locManager = CLLocationManager()
    
    override init() {
        super.init()
        setup()
    }
    
    func setup(){
        locManager.requestWhenInUseAuthorization()
        locManager.requestAlwaysAuthorization()
        displaySaved()
    }
    
    func displaySearch(result: [Geocoding]){
        self.result = result
        self.isSearching = true
        self.delegate?.reloadSearch(empty: (result.count == 0) ? true:false)
    }
    
    func displaySaved(){
        var saved: [SavedDisplayModel] = []
        for location in UserDefaults.getLocationList(){
            CurrentWeatherService.shared.getCurrentWeatherByCityName(cityName: location.fullName()){ (success, result, error, errorMessage, statusCode) in
                DispatchQueue.main.async {
                    if let r = result, let icon = r.weather?.icon, let temp = r.main?.temp {
                        saved.append(SavedDisplayModel(icon: icon, city: location.fullName(), temp: temp))
                    }
                    self.saved = saved
                    self.isSearching = false
                    self.delegate?.reloadSaved(empty: (saved.count == 0) ? true:false)
                }
            }
        }
    }
    
    func displayCurrent(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            if let coordinate = locManager.location?.coordinate{
                GeocodingService.shared.reverseGeocodingByCoordinate(lat: "\(coordinate.latitude)", lon: "\(coordinate.longitude)"){ (success, result, error, errorMessage, statusCode) in
                    DispatchQueue.main.async {
                        if result != nil, let r = result{
                            self.delegate?.display(current: r)
                        }
                    }
                }
            }
        }
    }
}
