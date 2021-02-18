//
//  SearchTableViewHeader.swift
//  WeatherApp
//
//  Created by joanne_cheng on 18/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

protocol SearchTableViewHeaderDelegate {
    func edit()
    func delete()
    func cancel()
}

class SearchTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var delegate: SearchTableViewHeaderDelegate?
        
    override func awakeFromNib() {
        self.setupUI()
    }
    
    // MARK: - Set Up
    func setupUI() {
        self.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.lblHeader.textColor = UIColor.black
        self.btnEdit.setTitle("Edit", for: .normal)
        self.btnDelete.setTitle("Delete", for: .normal)
        self.btnCancel.setTitle("Cancel", for: .normal)
        self.btnEdit.setTitleColor(UIColor.systemBlue, for: .normal)
        self.btnDelete.setTitleColor(UIColor.systemBlue, for: .normal)
        self.btnCancel.setTitleColor(UIColor.systemBlue, for: .normal)
    }
    
    func reset(){
        self.lblHeader.text = ""
        self.btnEdit.isHidden = true
        self.btnDelete.isHidden = true
        self.btnCancel.isHidden = true
    }
    
    func loadData(isSearching: Bool, hasRecord: Bool, isEditing: Bool) {
        if(isSearching){
            self.lblHeader.text = "Search Result"
            self.btnEdit.isHidden = true
        }else{
            self.lblHeader.text = "Search History"
            if(hasRecord){
                if(isEditing){
                    self.btnDelete.isHidden = false
                    self.btnCancel.isHidden = false
                }else{
                    self.btnEdit.isHidden = false
                }
            }
        }
    }

    @IBAction func btnDeletePressed(_ sender: Any) {
        delegate?.delete()
    }
    
    @IBAction func btnEditPressed(_ sender: Any) {
        delegate?.edit()
    }
    @IBAction func btnCancelPressed(_ sender: Any) {
        delegate?.cancel()
    }
}
