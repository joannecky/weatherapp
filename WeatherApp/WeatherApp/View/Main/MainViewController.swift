//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var vLocation: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var vWeather: UIView!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblWeatherTitle: UILabel!
    @IBOutlet weak var lblWeatherDesc: UILabel!
    
    @IBOutlet weak var vTemp: UIView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblTempMin: UILabel!
    @IBOutlet weak var lblTempMax: UILabel!
    @IBOutlet weak var imgTempMin: UIImageView!
    @IBOutlet weak var imgTempMax: UIImageView!
    
    @IBOutlet weak var vMain: UICollectionView!
    
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
        setupContent()
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
        setupNavigationBarRightBarButton()
    }
    
    private func setupNavigationBarRightBarButton() {
        let itemButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        itemButton.widthAnchor.constraint(equalToConstant: itemButton.frame.width).isActive = true
        itemButton.heightAnchor.constraint(equalToConstant: itemButton.frame.height).isActive = true
        itemButton.setImage(UIImage(named: "search")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        itemButton.tintColor = UIColor.systemOrange
        itemButton.addTarget(self, action: #selector(ClickSearchButton), for: .touchUpInside)
        itemButton.transform = CGAffineTransform(translationX: 5 , y: -5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: itemButton)
    }
    
    @objc private func ClickSearchButton() {
        let v = SearchView()
        PopoverView.showAlertView(content: v)
    }
    
    func setupContent(){
        self.title = vm.location?.name
        self.lblLocation.text = vm.location?.name
        if let state = vm.location?.state, state != ""{
            self.lblLocation.text = self.lblLocation.text ?? "" + ", \(state)"
            if let country = vm.location?.country, country != ""{
                self.lblLocation.text = self.lblLocation.text ?? "" + ", \(country)"
            }
        }
        self.lblDate.text = ""
        
        self.lblWeatherTitle.text = vm.weather?.weather?.main
        self.lblWeatherDesc.text = vm.weather?.weather?.desc
        if let id = vm.weather?.weather?.icon{
            let url = URL(string: " http://openweathermap.org/img/wn/\(id)@2x.png")
            let data = try? Data(contentsOf: url!)
            self.imgWeather.image = UIImage(data: data!)
        }
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
