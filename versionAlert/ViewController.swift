//
//  ViewController.swift
//  versionAlert
//
//  Created by haohao on 16/8/10.
//  Copyright © 2016年 haohao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnClick(_ sender: AnyObject) {
        //updateDetailArray:传入更新的内容数组
        //isForcedUpdate:是否进行强制更新
        //versionStr：版本号
        //updateURLString：跳转地址
        let versionAlertView = VersionAlertView.init(updatedDelArray: ["修复bug","增加内购功能"], isForcedUpdate: false, versionStr: "V2.5.0",updateURLString: "传入appsore跳转地址")
        
        versionAlertView.show()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

