//
//  SearchView.swift
//  WeatherApp
//
//  Created by joanne_cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
}

class SearchView: UIView{
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var btnGps: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Life Cycle
    func loadView() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        return Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)![0] as! UIView
    }
    
    // MARK: - setup
    
    func setup(){
        self.loadView()
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        self.btnGps.tintColor = UIColor.systemOrange
        self.btnGps.setImage(UIImage(named: "gps"), for: .normal)
        
        self.searchbar.delegate = self
        
    }
    
    func setupTableView(){
        tableview.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.reloadData()
    }
    
    @IBAction func btnGpsPressed(_ sender: Any) {
    }
}

extension SearchView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let decimalDigits = NSCharacterSet.decimalDigits
        let range = searchText.rangeOfCharacter(from: decimalDigits)
        if let r = range{
            CurrentWeatherService.shared.getCurrentWeatherByZipCode(zipCode: searchText){ (success, result, error, errorMessage, statusCode) in
                
            }
        }else{
            CurrentWeatherService.shared.getCurrentWeatherByCityName(cityName: searchText){ (success, result, error, errorMessage, statusCode) in
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! ListTableViewCell
        cell.reset()
        cell.loadData(model: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = DetailViewController()
        vc.model = list[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
