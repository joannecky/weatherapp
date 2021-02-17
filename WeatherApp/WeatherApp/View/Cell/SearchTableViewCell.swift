//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Init
    func initUI(){
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.lblTitle.textColor = UIColor.black
    }
    
    // MARK: - Reset
    func reset(){
        self.lblTitle.text = ""
    }
    
    func loadData(model : Geocoding) {
        self.lblTitle.text = model.fullName()
    }
}
