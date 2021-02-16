//
//  Cloud.swift
//  WeatherApp
//
//  Created by joanne_cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class Cloud: NSObject{
    var all: Int?
    
    init(dictionary:[String : Any]){
        if let all = dictionary["all"] as? Int{
            self.all = all
        }
    }
}
