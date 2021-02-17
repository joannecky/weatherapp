//
//  Snow.swift
//  WeatherApp
//
//  Created by joanne_cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class Snow: NSObject{
    var hr1: Double?
    var hr3: Double?
    
    init(dictionary:[String : Any]){
        if let hr1 = dictionary["1h"] as? Double{
            self.hr1 = hr1
        }
        if let hr3 = dictionary["3h"] as? Double{
            self.hr3 = hr3
        }
    }
}
