//
//  SearchDisplayModel.swift
//  WeatherApp
//
//  Created by joanne_cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class SearchDisplayModel{
    var title: String
    var isSelected: Bool
    
    init(title: String){
        self.title = title
        self.isSelected = false
    }
}
