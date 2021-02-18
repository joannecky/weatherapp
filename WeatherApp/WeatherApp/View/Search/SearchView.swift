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
        if(!vm.isEditing){
            self.btnGps.tintColor = UIColor(named: "secondaryColor")
            self.btnGps.setImage(UIImage(named: "gps"), for: .normal)
            self.searchbar.delegate = self
        }
    }
    
    func setupTableView(){
        tableview.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableview.register(UINib(nibName: "SearchTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchTableViewHeader")
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
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if(self.vm.isEditing){
            return false
        }else{
            return true
        }
    }
    
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
        return vm.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.reset()
        if(vm.isSearching){
            if vm.list.indices.contains(indexPath.row){
                cell.loadData(model: vm.list[indexPath.row], isEditing: false)
            }
        }else{
            if vm.list.indices.contains(indexPath.row){
                cell.loadData(model: vm.list[indexPath.row], isEditing: vm.isEditing)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(vm.isEditing){
            vm.list[indexPath.row].isSelected = !vm.list[indexPath.row].isSelected
            tableview.reloadData()
        }else{
            if vm.list.indices.contains(indexPath.row){
                if(vm.isSearching){
                    UserDefaults.addLocation(model: vm.data[indexPath.row])
                }
                searchDelegate?.display(model: vm.data[indexPath.row])
                delegate?.closePopoverView()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableview.dequeueReusableHeaderFooterView(withIdentifier: "SearchTableViewHeader") as! SearchTableViewHeader
        header.reset()
        let hasRecord = (self.vm.list.count > 0)
        header.loadData(isSearching: vm.isSearching, hasRecord: hasRecord, isEditing: vm.isEditing)
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
}

extension SearchView: SearchTableViewHeaderDelegate{
    func edit(){
        vm.isEditing = true
        tableview.reloadData()
    }
    
    func delete(){
        var new: [Geocoding] = []
        for i in 0 ..< vm.list.count{
            if(vm.list[i].isSelected == false){
                new.append(vm.data[i])
            }
        }
        UserDefaults.saveLocationList(list: new)
        vm.isEditing = false
        vm.displaySaved()
    }
    
    func cancel(){
        vm.isEditing = false
        tableview.reloadData()
    }
}
