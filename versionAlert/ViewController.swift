//
//  ViewController.swift
//  versionAlert
//
//  Created by haohao on 16/8/10.
//  Copyright © 2016年 haohao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var needToUpdate : Bool = false
    //假设服务器传过来的最新的版本号是0.0.3
    var newVersion : String = "1.0.5"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        获取当前的版本号
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        
      self.needToUpdate = self.compareVersionUpdate(newVersion: self.newVersion, currentVersion: currentVersion as! String)
    }
    func compareVersionUpdate(newVersion : String, currentVersion : String) -> Bool {
        let newVersionArr = newVersion.components(separatedBy: ".")
        let currVersionArr = currentVersion.components(separatedBy: ".")
        var newVersionCount = Double(newVersionArr.joined(separator: ""))
        var currVersionCount = Double(currVersionArr.joined(separator: ""))
        if newVersionArr.count > currVersionArr.count {
            currVersionCount = currVersionCount! * pow(10, Double(newVersionArr.count - currVersionArr.count))
        }else{
            newVersionCount = newVersionCount! * pow(10, Double(currVersionArr.count - newVersionArr.count))
        }
        if newVersionCount! > currVersionCount! {
            return true
        }else{
            return false
        }
    }

    @IBAction func btnClick(_ sender: AnyObject) {
        //updateDetailArray:传入更新的内容数组
        //isForcedUpdate:是否进行强制更新
        //versionStr：版本号
        //updateURLString：跳转地址
        if self.needToUpdate {
            let versionAlertView = VersionAlertView.init(updatedDelArray: ["修复bug","增加内购功能"], isForcedUpdate: false, versionStr: "V\(self.newVersion)",updateURLString: "传入appsore跳转地址")
            
            versionAlertView.show()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

