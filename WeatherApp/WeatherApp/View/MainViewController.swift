//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    func setup(){
        self.view.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1)
        setupNavigationBar()
        OpenWeatherManager.shared.getCurrentWeatherByCityName(cityName: "hongkong") { (success, res, error, message, code) in
            print(success)
        }
        OpenWeatherManager.shared.getCurrentWeatherByZipCode(zipCode: "94040") { (success, res, error, message, code) in
            print(success)
        }
        OpenWeatherManager.shared.getCurrentWeatherByCoordinates(lat: "35", lon: "139") { (success, res, error, message, code) in
            print(success)
        }
    }
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Weather App"
    }
    
}
