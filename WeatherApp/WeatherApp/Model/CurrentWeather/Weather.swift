//
//  Weather.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class Weather: NSObject{
    var id: Int?
    var main: String?
    var desc: String?
    var icon: String?
    
    init(dictionary:[String : Any]){
        if let id = dictionary["id"] as? Int{
            self.id = id
        }
        if let main = dictionary["main"] as? String{
            self.main = main
        }
        if let desc = dictionary["description"] as? String{
            self.desc = desc
        }
        if let icon = dictionary["icon"] as? String{
            self.icon = icon
        }
    }
}
