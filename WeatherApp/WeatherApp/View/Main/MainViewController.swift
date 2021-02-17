//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    var vm: MainViewModel = MainViewModel()
    
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
    }
    
//    func setupTableView(){
//         tableview.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
//         tableview.dataSource = self
//         tableview.delegate = self
//         tableview.reloadData()
//     }
//
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "My Weather"
    }
}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableview.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
//        cell.reset()
//        cell.loadData(model: list[indexPath.row])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var vc = DetailViewController()
//        vc.model = list[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
