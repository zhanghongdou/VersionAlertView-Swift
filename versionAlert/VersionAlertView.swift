
//
//  VersionAlertView.swift
//  hunbian
//
//  Created by haohao on 16/8/9.
//  Copyright © 2016年 haohao. All rights reserved.
//

import UIKit
class VersionAlertView: UIView {

    fileprivate lazy var topImageView: UIImageView = {
        let topImageView = UIImageView.init(image: UIImage.init(named: "wf_appupdate_bg"))
        return topImageView
    }()
    fileprivate lazy var bottomBtn: UIButton = {
        let bottomBtn = UIButton()
        bottomBtn.setBackgroundImage(UIImage.init(named: "wf_appupdate_u"), for: UIControlState())
        return bottomBtn
    }()
    
    fileprivate lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.setBackgroundImage(UIImage.init(named: "later-2"), for: UIControlState())
        return cancelBtn
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.text = "版本更新说明"
        return titleLabel
    }()
    
    fileprivate lazy var backView: UIView = {
       let backView = UIView.init(frame: UIScreen.main.bounds)
       backView.backgroundColor = UIColor.black
       backView.alpha = 0.2
       return backView
    }()
    
    fileprivate lazy var versionView: UIView = {
       let versionView = UIView()
        versionView.backgroundColor = UIColor.white
        versionView.clipsToBounds = true
        versionView.layer.cornerRadius = 5
        return versionView
    }()
    
    fileprivate lazy var versionLabel: UILabel = {
       let versionLabel = UILabel()
        versionLabel.backgroundColor = UIColor.clear
        versionLabel.textAlignment = .center
        versionLabel.textColor = UIColor.white
        return versionLabel
    }()
    
    var detailStrArray = Array<String>()
    var isforce = Bool()
    var detailAllLabel = Array<UILabel>()
    var versionLabelText = String()
    var updateStringPath = String()
    
    
    init(updatedDelArray : Array<String>, isForcedUpdate : Bool, versionStr: String, updateURLString: String) {
        super.init(frame: UIScreen.main.bounds)
        self.detailStrArray = updatedDelArray
        self.isforce = isForcedUpdate
        self.updateStringPath = updateURLString
        self.versionLabelText = versionStr
        if self.isforce {
            self.cancelBtn.isHidden = true
        }else{
            self.cancelBtn.isHidden = false
        }
        self.creatUI()
    }
    
    func creatUI() {
        self.addSubview(self.backView)
        self.versionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.versionView)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.versionView.addSubview(self.titleLabel)
        self.topImageView.translatesAutoresizingMaskIntoConstraints = false
        self.versionView.addSubview(self.topImageView)
        self.cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        self.versionView.addSubview(self.cancelBtn)
        self.versionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.versionView.addSubview(self.versionLabel)
        self.versionLabel.text = self.versionLabelText
        self.bottomBtn.translatesAutoresizingMaskIntoConstraints = false
        self.versionView.addSubview(self.bottomBtn)
        self.bottomBtn.addTarget(self, action: #selector(VersionAlertView.updateRightNow(_:)), for: .touchUpInside)
        self.cancelBtn.addTarget(self, action: #selector(VersionAlertView.updateLater(_:)), for: .touchUpInside)
        self.creatAllLabel()
        self.setLayout()
    }
    
    func updateRightNow(_ sender : UIButton) {
        UIApplication.shared.openURL(URL.init(string: self.updateStringPath)!)
    }
    
    func updateLater(_ sender : UIButton) {
        for constraint in self.constraints {
            if constraint.firstAttribute == .centerY && constraint.firstItem as! NSObject == self.versionView && constraint.secondItem as! NSObject == self.backView {
                self.removeConstraint(constraint)
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: { 
                    self.backView.alpha = 0.05
                    let versionViewTop = NSLayoutConstraint.init(item: self.versionView, attribute: .top, relatedBy: .equal, toItem: self.backView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
                    versionViewTop.isActive = true
                    self.layoutIfNeeded()
                    }, completion: { (finished) in
                        self.removeFromSuperview()
                })
            }
        }
    }
    
    func creatAllLabel() {
        for str in self.detailStrArray {
            let detailLabel = UILabel()
            detailLabel.text = str
            detailLabel.textColor = UIColor.gray
            detailLabel.font = UIFont.systemFont(ofSize: 14)
            detailLabel.textAlignment = .center
            detailLabel.numberOfLines = 0
            self.detailAllLabel.append(detailLabel)
            self.versionView.addSubview(detailLabel)
        }
    }
    
    func setLayout() {
        
        let versionViewLeft = NSLayoutConstraint.init(item: self.versionView, attribute: .left, relatedBy: .equal, toItem: self.backView, attribute: .left, multiplier: 1.0, constant: 30.0)
        let versionViewCenterX = NSLayoutConstraint.init(item: self.versionView, attribute: .centerX, relatedBy: .equal, toItem: self.backView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let versionViewCenterY = NSLayoutConstraint.init(item: self.versionView, attribute: .centerY, relatedBy: .equal, toItem: self.backView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let versionViewRight = NSLayoutConstraint.init(item: self.versionView, attribute: .right, relatedBy: .equal, toItem: self.backView, attribute: .right, multiplier: 1.0, constant: -30.0)
        versionViewLeft.isActive = true
        versionViewCenterX.isActive = true
        versionViewCenterY.isActive = true
        versionViewRight.isActive = true
        
        
        let topImageViewLeft = NSLayoutConstraint.init(item: self.topImageView, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let topImageViewRight = NSLayoutConstraint.init(item: self.topImageView, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: 0.0)
        let topImageViewTop = NSLayoutConstraint.init(item: self.topImageView, attribute: .top, relatedBy: .equal, toItem: self.versionView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let topImageViewHeight = NSLayoutConstraint.init(item: self.topImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 180.0)
        topImageViewLeft.isActive = true
        topImageViewRight.isActive = true
        topImageViewTop.isActive = true
        topImageViewHeight.isActive = true

        
        let versionLabelCenterX = NSLayoutConstraint.init(item: self.versionLabel, attribute: .centerX, relatedBy: .equal, toItem: self.versionView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let versionLabelBottom = NSLayoutConstraint.init(item: self.versionLabel, attribute: .bottom, relatedBy: .equal, toItem: self.topImageView, attribute: .bottom, multiplier: 1.0, constant: -30.0)
        let versionLabelHeight = NSLayoutConstraint.init(item: self.versionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0)
        versionLabelCenterX.isActive = true
        versionLabelBottom.isActive = true
        versionLabelHeight.isActive = true
        
        let cancelBtnWidth = NSLayoutConstraint.init(item: self.cancelBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0)
        let cancelBtnHeight = NSLayoutConstraint.init(item: self.cancelBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0)
        let cancelBtnRight = NSLayoutConstraint.init(item: self.cancelBtn, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -10.0)
        let cancelBtnTop = NSLayoutConstraint.init(item: self.cancelBtn, attribute: .top, relatedBy: .equal, toItem: self.versionView, attribute: .top, multiplier: 1.0, constant: 10)
        cancelBtnWidth.isActive = true
        cancelBtnHeight.isActive = true
        cancelBtnTop.isActive = true
        cancelBtnRight.isActive = true
        
        let titleLabelCenterX = NSLayoutConstraint.init(item: self.titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.versionView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let titleLabelTop = NSLayoutConstraint.init(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.topImageView, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        titleLabelTop.isActive = true
        titleLabelCenterX.isActive = true
        
        
        if self.detailStrArray.count > 0 {
            if self.detailStrArray.count == 1 {
                let label = self.detailAllLabel[0]
                label.translatesAutoresizingMaskIntoConstraints = false
                let labelLeft = NSLayoutConstraint.init(item: label, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 10.0)
                let labelRight = NSLayoutConstraint.init(item: label, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -10.0)
                let labelTop = NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
                labelLeft.isActive = true
                labelRight.isActive = true
                labelTop.isActive = true
            }
            
            if self.detailStrArray.count == 2 {
                let label1 = self.detailAllLabel[0]
                label1.translatesAutoresizingMaskIntoConstraints = false
                let label1Left = NSLayoutConstraint.init(item: label1, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 10.0)
                let label1Right = NSLayoutConstraint.init(item: label1, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -10.0)
                let label1Top = NSLayoutConstraint.init(item: label1, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
                label1Left.isActive = true
                label1Right.isActive = true
                label1Top.isActive = true
                
                let label2 = self.detailAllLabel[1]
                label2.translatesAutoresizingMaskIntoConstraints = false
                let label2Left = NSLayoutConstraint.init(item: label2, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 10.0)
                let label2Right = NSLayoutConstraint.init(item: label2, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -10.0)
                let label2Top = NSLayoutConstraint.init(item: label2, attribute: .top, relatedBy: .equal, toItem: label1, attribute: .bottom, multiplier: 1.0, constant: 10.0)
                label2Left.isActive = true
                label2Right.isActive = true
                label2Top.isActive = true
            }
            
            if self.detailStrArray.count > 2 {
                
                for (index, label) in self.detailAllLabel.enumerated() {
                    label.translatesAutoresizingMaskIntoConstraints = false
                    if index == 0 {
                        let labelLeft = NSLayoutConstraint.init(item: label, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 10.0)
                        let labelRight = NSLayoutConstraint.init(item: label, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -10.0)
                        let labelTop = NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
                        labelLeft.isActive = true
                        labelRight.isActive = true
                        labelTop.isActive = true
                    }else{
                        let lastLabel = self.detailAllLabel[index - 1]
                        let labelLeft = NSLayoutConstraint.init(item: label, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 10.0)
                        let labelRight = NSLayoutConstraint.init(item: label, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -10.0)
                        let labelTop = NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: lastLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
                        labelLeft.isActive = true
                        labelRight.isActive = true
                        labelTop.isActive = true
                        }
                    }
                    
                }
            
            let bottomBtnLeft = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 80.0)
            let bottomBtnRight = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -80.0)
            let bottomBtnTop = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .top, relatedBy: .equal, toItem: self.detailAllLabel.last, attribute: .bottom, multiplier: 1.0, constant: 10.0)
            let bottomBtnBottom = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .bottom, relatedBy: .equal, toItem: self.versionView, attribute: .bottom, multiplier: 1.0, constant: -10.0)
            let bottomBtnHeight = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0)
            bottomBtnLeft.isActive = true
            bottomBtnRight.isActive = true
            bottomBtnBottom.isActive = true
            bottomBtnTop.isActive = true
            bottomBtnHeight.isActive = true
        }else{
            let bottomBtnLeft = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .left, relatedBy: .equal, toItem: self.versionView, attribute: .left, multiplier: 1.0, constant: 80.0)
            let bottomBtnRight = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .right, relatedBy: .equal, toItem: self.versionView, attribute: .right, multiplier: 1.0, constant: -80.0)
            let bottomBtnTop = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
            let bottomBtnBottom = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .bottom, relatedBy: .equal, toItem: self.versionView, attribute: .bottom, multiplier: 1.0, constant: -10)
            let bottomBtnHeight = NSLayoutConstraint.init(item: self.bottomBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
            bottomBtnLeft.isActive = true
            bottomBtnRight.isActive = true
            bottomBtnBottom.isActive = true
            bottomBtnTop.isActive = true
            bottomBtnHeight.isActive = true
        }
    }
    
    
    func show() {
        //注意，这里为了避免windows不存在，所以采用的是下诉方法，如果开发者使用到自己的项目中的时候注意改为[UIApplication .sharedApplication().keyWindow?.addSubview(self),否则会添加不成功，如果你不明白原因，建议你去了解一下window的层级显示问题
        
       UIApplication.shared.windows[0].addSubview(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}










