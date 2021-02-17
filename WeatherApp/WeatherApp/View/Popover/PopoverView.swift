//
//  PopoverView.swift
//  WeatherApp
//
//  Created by joanne_cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

protocol PopoverViewDelegate {
    func closePopoverView()
    func changeHeight(height: CGFloat)
}

class PopoverView: UIView{
    
    private var defaultMinViewHeight : CGFloat = 50
    private var defaultDetectCloseViewHeight : CGFloat = 50
    private var interactionDistance: CGFloat = 0

    @IBOutlet var nsViewHeight: NSLayoutConstraint!
    @IBOutlet var nsRootBottom: NSLayoutConstraint!
    @IBOutlet var vBackground: UIView!
    @IBOutlet var vRoot: UIView!
    @IBOutlet var vIndicator: UIView!
    @IBOutlet var vContent: UIView!
    
    // MARK: - init

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
        return Bundle.main.loadNibNamed("PopoverView", owner: self, options: nil)![0] as! UIView
    }
    
    // MARK: - setup

    func setup(){
        self.loadView()
        self.setupGesture()
        self.setupLayout()
    }
    
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.vIndicator.layoutIfNeeded()
        self.vIndicator.layer.cornerRadius = vIndicator.frame.size.height / 2
        self.vIndicator.backgroundColor = UIColor.gray
        self.vRoot.layer.cornerRadius = 10
        self.vRoot.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupGesture(){
        self.vBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onBackgroundClick)))
        self.vRoot.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(draggedView)))
    }
    
    func setupContentView(content: UIView){
        let topY: CGFloat = UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - self.vContent.frame.origin.y - 45
        content.frame = self.vContent.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.vContent.addSubview(content)
        self.nsViewHeight.constant = topY
        self.layoutIfNeeded()
        self.setupViewAnimate()
    }
    
    func setupViewAnimate(){
        self.vBackground.alpha = 0
        self.nsRootBottom.constant = -self.vRoot.frame.size.height
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.vBackground.alpha = 0.3
            self.nsRootBottom.constant = 0
            self.layoutIfNeeded()
        })
    }
    
    // MARK: - UIPanGestureRecognizer
    @objc func draggedView(sender : UIPanGestureRecognizer){
        let translation = sender.translation(in: self).y
        let velocity = sender.velocity(in: self).y
        sender.setTranslation(CGPoint.zero, in: self)
        switch sender.state {
        case .began: gestureBegan()
        case .changed: gestureChanged(translation: translation , velocity: velocity)
        case .cancelled: gestureCancelled(translation: translation , velocity: velocity)
        case .ended: gestureEnded(translation: translation , velocity: velocity)
        default: break
        }
    }
    
    // MARK: - Gesture handling

    private func gestureBegan() {
        self.interactionDistance = self.nsViewHeight.constant
    }

    private func gestureChanged(translation: CGFloat, velocity: CGFloat) {
        let viewHeight = self.nsViewHeight.constant - translation
        guard viewHeight > self.defaultMinViewHeight else {
            return
        }
        guard viewHeight + self.vContent.frame.origin.y < UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height  else {
            return
        }
        guard viewHeight <= self.interactionDistance else {
            return
        }
        self.nsViewHeight.constant = viewHeight
    }

    private func gestureCancelled(translation: CGFloat, velocity: CGFloat) {
        self.gestureEnded(translation: translation, velocity: velocity)
    }

    private func gestureEnded(translation: CGFloat, velocity: CGFloat) {
        if self.interactionDistance - self.nsViewHeight.constant > defaultDetectCloseViewHeight {
            self.closeAlertView()
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.nsViewHeight.constant = self.interactionDistance
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Button Action
    @objc func onBackgroundClick(sender : UITapGestureRecognizer){
        self.closeAlertView()
    }
    
    // MARK: - Close AlertView
    func closeAlertView(){
//        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.nsRootBottom.constant = -self.vRoot.frame.size.height
            self.layoutIfNeeded()
        }, completion: { (success: Bool) in
            UIView.animate(withDuration: 0.15, animations: {
                self.vBackground.alpha = 0
            }, completion: { (success: Bool) in
                self.removeFromSuperview()
            })
        })
    }
    
    // MARK: - show AlertView
    class func showAlertView(content: UIView) -> PopoverView{
        let vc : PopoverView = PopoverView()
        if let window :UIWindow = UIApplication.shared.keyWindow {
            vc.frame = window.bounds
            window.addSubview(vc)
            vc.setupContentView(content: content)
        }
        return vc
    }
    
}

// MARK: - Delegate
extension PopoverView: PopoverViewDelegate {
    func closePopoverView() {
        self.closeAlertView()
    }
    
    func changeHeight(height: CGFloat){
        self.nsViewHeight.constant = height
    }
}
