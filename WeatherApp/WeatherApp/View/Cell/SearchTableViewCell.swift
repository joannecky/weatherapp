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
    @IBOutlet weak var imgEdit: UIImageView!
    @IBOutlet weak var nsTitleLeading: NSLayoutConstraint!
    
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
        self.nsTitleLeading.constant = 5
        self.imgEdit.image = nil
    }
    
    func loadData(model : SearchDisplayModel, isEditing: Bool) {
        self.lblTitle.text = model.title
        if isEditing{
            if model.isSelected{
                imgEdit.image = UIImage(named: "checkbox")
            }else{
                imgEdit.image = UIImage(named: "uncheckbox")
            }
        }else{
            self.nsTitleLeading.constant = -25
        }
    }
}
