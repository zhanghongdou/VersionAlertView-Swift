
//
//  VersionAlertView.swift
//  hunbian
//
//  Created by haohao on 16/8/9.
//  Copyright © 2016年 haohao. All rights reserved.
//

import UIKit
import SnapKit
class VersionAlertView: UIView {

    private lazy var topImageView: UIImageView = {
        let topImageView = UIImageView.init(image: UIImage.init(named: "wf_appupdate_bg"))
        return topImageView
    }()
    private lazy var bottomBtn: UIButton = {
        let bottomBtn = UIButton()
        bottomBtn.setBackgroundImage(UIImage.init(named: "wf_appupdate_u"), forState: .Normal)
        return bottomBtn
    }()
    
    private lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.backgroundColor = UIColor.clearColor()
        cancelBtn.setBackgroundImage(UIImage.init(named: "later-2"), forState: .Normal)
        return cancelBtn
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(17)
        titleLabel.textAlignment = .Center
        titleLabel.text = "版本更新说明"
        return titleLabel
    }()
    
    private lazy var backView: UIView = {
       let backView = UIView.init(frame: UIScreen.mainScreen().bounds)
       backView.backgroundColor = UIColor.blackColor()
       backView.alpha = 0.2
       return backView
    }()
    
    private lazy var versionView: UIView = {
       let versionView = UIView()
        versionView.backgroundColor = UIColor.whiteColor()
        versionView.clipsToBounds = true
        versionView.layer.cornerRadius = 5
        return versionView
    }()
    
    private lazy var versionLabel: UILabel = {
       let versionLabel = UILabel()
        versionLabel.backgroundColor = UIColor.clearColor()
        versionLabel.textAlignment = .Center
        versionLabel.textColor = UIColor.whiteColor()
        return versionLabel
    }()
    
    var detailStrArray = Array<String>()
    var isforce = Bool()
    var detailAllLabel = Array<UILabel>()
    var versionLabelText = String()
    var updateStringPath = String()
    
    
    init(updatedDelArray : Array<String>, isForcedUpdate : Bool, versionStr: String, updateURLString: String) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.detailStrArray = updatedDelArray
        self.isforce = isForcedUpdate
        self.updateStringPath = updateURLString
        self.versionLabelText = versionStr
        if self.isforce {
            self.cancelBtn.hidden = true
        }else{
            self.cancelBtn.hidden = false
        }
        self.creatUI()
    }
    
    func creatUI() {
        self.addSubview(self.backView)
        self.addSubview(self.versionView)
        self.versionView.addSubview(self.titleLabel)
        self.versionView.addSubview(self.topImageView)
        self.versionView.addSubview(self.cancelBtn)
        self.versionView.addSubview(self.versionLabel)
        self.versionLabel.text = self.versionLabelText
        self.versionView.addSubview(self.bottomBtn)
        self.bottomBtn.addTarget(self, action: #selector(VersionAlertView.updateRightNow(_:)), forControlEvents: .TouchUpInside)
        self.cancelBtn.addTarget(self, action: #selector(VersionAlertView.updateLater(_:)), forControlEvents: .TouchUpInside)
        self.creatAllLabel()
        self.setLayout()
    }
    
    func updateRightNow(sender : UIButton) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: self.updateStringPath)!)
    }
    
    func updateLater(sender : UIButton) {
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            self.versionView.snp_remakeConstraints { (make) in
                make.left.equalTo(self.backView.snp_left).offset(30)
                make.right.equalTo(self.backView.snp_right).offset(-30)
                make.centerX.equalTo(self.backView)
                make.top.equalTo(self.backView.snp_bottom)
            }
            self.layoutIfNeeded()
            }) { (finished) in
                self.removeFromSuperview()
        }
    }
    
    func creatAllLabel() {
        for str in self.detailStrArray {
            let detailLabel = UILabel()
            detailLabel.text = str
            detailLabel.textColor = UIColor.grayColor()
            detailLabel.font = UIFont.systemFontOfSize(14)
            detailLabel.textAlignment = .Center
            detailLabel.numberOfLines = 0
            self.detailAllLabel.append(detailLabel)
            self.versionView.addSubview(detailLabel)
        }
    }
    
    func setLayout() {
        self.versionView.snp_makeConstraints { (make) in
            make.left.equalTo(self.backView.snp_left).offset(30)
            make.center.equalTo(self.backView)
            make.right.equalTo(self.backView.snp_right).offset(-30)
        }
        
        self.topImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.versionView)
            make.right.equalTo(self.versionView)
            make.top.equalTo(self.versionView)
            make.height.equalTo(180)
        }

        self.versionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.versionView)
            make.bottom.equalTo(self.topImageView.snp_bottom).offset(-30)
            make.height.equalTo(20)
        }

        self.cancelBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(20, 20))
            make.right.equalTo(self.versionView.snp_right).offset(-10)
            make.top.equalTo(self.versionView.snp_top).offset(10)
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.versionView)
            make.top.equalTo(self.topImageView.snp_bottom).offset(10)
        }
        
        if self.detailStrArray.count > 0 {
            if self.detailStrArray.count == 1 {
                let label = self.detailAllLabel[0]
                label.snp_makeConstraints { (make) in
                    make.left.equalTo(self.versionView.snp_left).offset(10)
                    make.right.equalTo(self.versionView.snp_right).offset(-10)
                    make.top.equalTo(self.titleLabel.snp_bottom).offset(10)
                }
            }
            
            if self.detailStrArray.count == 2 {
                let label1 = self.detailAllLabel[0]
                label1.snp_makeConstraints(closure: { (make) in
                    make.left.equalTo(self.versionView.snp_left).offset(10)
                    make.right.equalTo(self.versionView.snp_right).offset(-10)
                    make.top.equalTo(self.titleLabel.snp_bottom).offset(10)
                })
                
                let label2 = self.detailAllLabel[1]
                label2.snp_makeConstraints(closure: { (make) in
                    make.left.equalTo(self.versionView.snp_left).offset(10)
                    make.right.equalTo(self.versionView.snp_right).offset(-10)
                    make.top.equalTo(label1.snp_bottom).offset(10)
                })
            }
            
            if self.detailStrArray.count > 2 {
                
                for (index, label) in self.detailAllLabel.enumerate() {
                    if index == 0 {
                        label.snp_makeConstraints { (make) in
                            make.left.equalTo(self.versionView.snp_left).offset(10)
                            make.right.equalTo(self.versionView.snp_right).offset(-10)
                            make.top.equalTo(self.titleLabel.snp_bottom).offset(10)
                        }
                    }else{
                        let lastLabel = self.detailAllLabel[index - 1]
                            label.snp_makeConstraints { (make) in
                                make.left.equalTo(self.versionView.snp_left).offset(10)
                                make.right.equalTo(self.versionView.snp_right).offset(-10)
                                make.top.equalTo(lastLabel.snp_bottom).offset(10)
                        }
                    }
                    
                }
            }
            
            self.bottomBtn.snp_makeConstraints { (make) in
                make.left.equalTo(self.versionView.snp_left).offset(80)
                make.right.equalTo(self.versionView.snp_right).offset(-80)
                make.top.equalTo(self.detailAllLabel.last!.snp_bottom).offset(10)
                make.bottom.equalTo(self.versionView.snp_bottom).offset(-10)
                make.height.equalTo(60)
            }
            
        }else{
            self.bottomBtn.snp_makeConstraints { (make) in
                make.left.equalTo(self.versionView.snp_left).offset(80)
                make.right.equalTo(self.versionView.snp_right).offset(-80)
                make.top.equalTo(self.titleLabel.snp_bottom).offset(10)
                make.bottom.equalTo(self.versionView.snp_bottom).offset(-10)
                make.height.equalTo(44)
            }
        }
    }
    
    
    func show() {
        //注意，这里为了避免windows不存在，所以采用的是下诉方法，如果开发者使用到自己的项目中的时候注意改为[UIApplication .sharedApplication().keyWindow?.addSubview(self),否则会添加不成功，如果你不明白原因，建议你去了解一下window的层级显示问题
        
       UIApplication.sharedApplication().windows[0].addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}










