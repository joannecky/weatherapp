//
//  SearchView.swift
//  WeatherApp
//
//  Created by joanne_cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func display(model: Geocoding)
    func display(alert: UIAlertController)
}

class SearchView: UIView{
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var btnGps: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var vm: SearchViewModel = SearchViewModel()
    var delegate: PopoverViewDelegate?
    var searchDelegate: SearchViewDelegate?
    
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
        self.vm.delegate = self
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        self.btnGps.tintColor = UIColor(named: "secondaryColor")
        self.btnGps.setImage(UIImage(named: "gps"), for: .normal)
        self.searchbar.delegate = self
        
    }
    
    func setupTableView(){
        tableview.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableview.register(UINib(nibName: "SavedTableViewCell", bundle: nil), forCellReuseIdentifier: "SavedTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
        tableview.reloadData()
    }
    
    @IBAction func btnGpsPressed(_ sender: Any) {
        vm.displayCurrent()
    }
    
    class func showAlertView() -> SearchView{
        var v = SearchView()
        let alert = PopoverView.showAlertView(content: v)
        v.delegate = alert
        return v
    }
}

extension SearchView: SearchViewModelDelegate{
    func reloadSaved(empty: Bool) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
            if(!empty){
                self.tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    
    func reloadSearch(empty: Bool) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
            if(!empty){
                self.tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    
    func display(current: Geocoding) {
        UserDefaults.addLocation(model: current)
        searchDelegate?.display(model: current)
        delegate?.closePopoverView()
    }
    
    func display(alert: UIAlertController) {
        searchDelegate?.display(alert: alert)
    }
}

extension SearchView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let input = searchBar.text, input != ""{
            let decimalDigits = NSCharacterSet.decimalDigits
            let range = searchText.rangeOfCharacter(from: decimalDigits)
            if let r = range{
                GeocodingService.shared.directGeocodingByZipCode(input: input){ (success, result, error, errorMessage, statusCode) in
                    if let r = result{
                        self.vm.displaySearch(result: [r])
                    }else{
                        self.vm.displaySearch(result: [])
                    }
                }
            }else{
                GeocodingService.shared.directGeocodingByCityName(input: input){ (success, result, error, errorMessage, statusCode) in
                    if let r = result, r.count > 0{
                        self.vm.displaySearch(result: r)
                    }else{
                        self.vm.displaySearch(result: [])
                    }
                }
            }
        }else{
            self.vm.displaySaved()
        }
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(vm.isSearching){
            return vm.result?.count ?? 0
        }else{
            return vm.saved?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(vm.isSearching){
            let cell = tableview.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
            cell.reset()
            if let result = vm.result, result.indices.contains(indexPath.row){
                cell.loadData(model: result[indexPath.row])
            }
            return cell
        }else{
            let cell = tableview.dequeueReusableCell(withIdentifier: "SavedTableViewCell") as! SavedTableViewCell
            cell.reset()
            if let r = vm.saved, r.indices.contains(indexPath.row){
                cell.loadData(model: r[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(vm.isSearching){
            if let result = vm.result, result.indices.contains(indexPath.row){
                UserDefaults.addLocation(model: result[indexPath.row])
                searchDelegate?.display(model: result[indexPath.row])
                delegate?.closePopoverView()
            }
        }else{
            for location in UserDefaults.getLocationList(){
                if let saved = vm.saved, saved[indexPath.row].city == location.fullName(){
                    searchDelegate?.display(model: UserDefaults.getLocationList()[indexPath.row])
                    delegate?.closePopoverView()
                }
            }
            
        }
    }
}
