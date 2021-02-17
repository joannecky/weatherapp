//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Joanne Cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//


import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblRemark: UILabel!
    @IBOutlet weak var vLeftSeparator: UIView!
    @IBOutlet weak var vRightSeparator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }
    
    // MARK: - Init
    func initUI(){
        self.backgroundColor = UIColor.clear
        self.lblTitle.textColor = UIColor.darkGray
        self.lblDesc.textColor = UIColor.black
        self.lblRemark.textColor = UIColor.black
        self.vLeftSeparator.backgroundColor = UIColor.darkGray
        self.vRightSeparator.backgroundColor = UIColor.darkGray
    }
    
    // MARK: - Reset
    func reset(){
        self.lblTitle.text = ""
        self.lblDesc.text = ""
        self.lblRemark.text = ""
    }
    
    func loadData(model : WeatherCollectionDisplayModel) {
        self.lblTitle.text = model.title
        self.lblDesc.text = model.desc
        self.lblRemark.text = model.remark
        if(model.position == .first){
            vLeftSeparator.isHidden = true
        }else if(model.position == .last){
            vRightSeparator.isHidden = true
        }

    }
}
