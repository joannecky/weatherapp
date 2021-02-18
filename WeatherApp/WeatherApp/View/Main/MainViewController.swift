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
        self.view.backgroundColor = UIColor.white
        self.vm.delegate = self
        setupNavigationBar()
        setupCollectionView()
        setupContent()
    }
    
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
        let itemButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        itemButton.widthAnchor.constraint(equalToConstant: itemButton.frame.width).isActive = true
        itemButton.heightAnchor.constraint(equalToConstant: itemButton.frame.height).isActive = true
        itemButton.setImage(UIImage(named: "search")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        itemButton.tintColor = UIColor.systemOrange
        itemButton.addTarget(self, action: #selector(ClickSearchButton), for: .touchUpInside)
        itemButton.transform = CGAffineTransform(translationX: 5 , y: 0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: itemButton)
    }
    
    func setupCollectionView(){
        vMain.delegate = self
        vMain.dataSource = self
        vMain.register(UINib.init(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        vMain.backgroundColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
        vMain.layer.cornerRadius = 5
    }
    
    @objc private func ClickSearchButton() {
        let v = SearchView.showAlertView()
        v.searchDelegate = self
    }
    
    func reset(){
        DispatchQueue.main.async {
            self.title = "My Weather"
            self.lblLocation.text = ""
            self.lblDate.text = ""
            
            self.lblWeatherTitle.text = ""
            self.lblWeatherDesc.text = ""
            self.imgWeather.image = nil
            
            self.lblTemp.text = ""
            self.lblTempMin.text = ""
            self.lblTempMax.text = ""
            
            self.vTemp.isHidden = true
            self.imgTempMin.image = nil
            self.imgTempMax.image = nil
            
            self.vMain.isHidden = true
        }
    }
    
    func setupContent(){
        reset()
        if vm.location != nil{
            DispatchQueue.main.async {
                self.title = self.vm.location?.name
                self.lblLocation.text = self.vm.location?.fullName()
                self.lblDate.text = ""
                self.lblWeatherTitle.text = self.vm.weather?.weather?.main
                self.lblWeatherDesc.text = self.vm.weather?.weather?.desc
                self.lblWeatherDesc.textColor = UIColor.darkGray
                self.lblWeatherDesc.numberOfLines = 0
                self.lblWeatherDesc.sizeToFit()
                if let id = self.vm.weather?.weather?.icon{
                    if let url = URL(string: "http://openweathermap.org/img/wn/\(id)@2x.png"){
                        let data = try? Data(contentsOf: url)
                        self.imgWeather.image = UIImage(data: data!)
                    }
                }
                
                self.vTemp.isHidden = false
                if let temp = self.vm.weather?.main?.temp{
                    self.lblTemp.text = "\(round(temp*10)/10) °C"
                }
                if let temp_min = self.vm.weather?.main?.temp_min{
                    self.lblTempMin.text = "\(round(temp_min*10)/10) °C"
                }
                if let temp_max = self.vm.weather?.main?.temp_max{
                    self.lblTempMax.text = "\(round(temp_max*10)/10) °C"
                }
                self.imgTempMin.image = UIImage(named: "temp")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                self.imgTempMin.tintColor = UIColor.systemBlue
                self.imgTempMax.image = UIImage(named: "temp")
                self.imgTempMax.tintColor = UIColor.systemRed
                
                if(self.vm.list?.count ?? 0 > 0){
                    self.vMain.isHidden = false
                }
                self.vMain.reloadData()
            }
        }
    }
}

extension MainViewController: SearchViewDelegate{
    func display(model: Geocoding){
        vm.display(location: model)
    }
}

extension MainViewController: MainViewModelDelegate{
    func reload(){
        setupContent()
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width / CGFloat(self.vm.list?.count ?? 0), height: 75)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WeatherCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        cell.reset()
          if let r = vm.list, r.indices.contains(indexPath.row){
              cell.loadData(model: r[indexPath.row])
          }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
