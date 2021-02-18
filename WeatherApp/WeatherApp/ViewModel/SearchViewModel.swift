//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchViewModelDelegate {
    func reloadSearch(empty: Bool)
    func reloadSaved(empty: Bool)
    func display(current: Geocoding)
    func display(alert: UIAlertController)
}

class SearchViewModel: NSObject{
    
    var data: [Geocoding] = []
    var list: [SearchDisplayModel] = []
    var isSearching: Bool = false
    var isEditing: Bool = false
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
        self.data = result
        self.list.removeAll()
        for r in data{
            self.list.append(SearchDisplayModel(title: r.fullName()))
        }
        self.isSearching = true
        self.delegate?.reloadSearch(empty: (list.count == 0) ? true:false)
    }
    
    func displaySaved(){
        self.list.removeAll()
        self.data = UserDefaults.getLocationList()
        for r in data{
            self.list.append(SearchDisplayModel(title: r.fullName()))
        }
        self.isSearching = false
        self.delegate?.reloadSearch(empty: (list.count == 0) ? true:false)
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
                        }else{
                            let alert = UIAlertController(title: "Error", message:"No weather data in your current location", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
                            self.delegate?.display(alert: alert )
                        }
                    }
                }
            }
        }
    }
}
