//
//  SavedTableViewCell.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//


import UIKit

class SavedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblTemp: UILabel!
    
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
        self.lblCity.textColor = UIColor.black
        self.lblTemp.textColor = UIColor.black
    }
    
    // MARK: - Reset
    func reset(){
        self.lblCity.text = ""
        self.lblTemp.text = ""
        self.imgWeather.image = nil
    }
    
    func loadData(model : SavedDisplayModel) {
        if let url = URL(string: "http://openweathermap.org/img/wn/\(model.icon)@2x.png"){
            let data = try? Data(contentsOf: url)
            self.imgWeather.image = UIImage(data: data!)
        }
        self.lblCity.text = model.city
        self.lblTemp.text = "\(round(model.temp*10)/10) °C"
        
    }
}
