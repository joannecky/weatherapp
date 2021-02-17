//
//  UserDefaults+Location.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let UserDefaultsLocationKey = "UserDefaultsLocation"
    
    @objc static func getLocationList() -> [Geocoding]{
        if UserDefaults.standard.object(forKey: UserDefaultsLocationKey) != nil {
            if let savedUserData = UserDefaults.standard.object(forKey: UserDefaultsLocationKey) as? Data {
                let decoder = JSONDecoder()
                if let savedUser = try? decoder.decode([Geocoding].self, from: savedUserData) {
                    return savedUser
                }
            }
        }
        saveLocationList(list: [])
        return []
    }
    
    
    @objc static func saveLocationList(list: [Geocoding]){
        let encoder = JSONEncoder()
        if let encodedModel = try? encoder.encode(list) {
            UserDefaults.standard.set(encodedModel, forKey: UserDefaultsLocationKey)
        }
        UserDefaults.standard.synchronize()
    }
    
    
    @objc static func addLocation(model: Geocoding){
        let list = getLocationList()
        for i in 0..<list.count{
            if((list[i].name == model.name) && (list[i].state == model.state) && (list[i].country == model.country)){
                return
            }
        }
        var new = [model]
        new.append(contentsOf: list)
        saveLocationList(list: new)
    }
    
    @objc static func removeLocation(model: Geocoding){
        var list = getLocationList()
        for i in 0..<list.count{
            if((list[i].name == model.name) && (list[i].state == model.state) && (list[i].country == model.country)){
                list.remove(at: i)
                saveLocationList(list: list)
                return
            }
        }
    }
}
