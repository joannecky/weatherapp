//
//  SearchTableViewHeader.swift
//  WeatherApp
//
//  Created by joanne_cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class SearchTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblHeader: UILabel!
    
    override func awakeFromNib() {
        self.setupUI()
    }
    
    // MARK: - Set Up
    func setupUI() {
        self.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        lblHeader.textColor = UIColor.black
    }
    
    func reset(){
        self.lblHeader.text = ""
    }
    
    func loadData(isSearching: Bool) {
        if(isSearching){
            self.lblHeader.text = "Search Result"
        }else{
            self.lblHeader.text = "Search History"
        }
    }
}
