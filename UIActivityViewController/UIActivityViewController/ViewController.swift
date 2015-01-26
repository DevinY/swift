//
//  ViewController.swift
//  UIActivityViewController
//
//  Created by Devin Yang on 2015/1/2.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var activityViewController:UIActivityViewController!

    @IBOutlet weak var shareField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        shareField.placeholder="請輸入要分享的東西"
        
        //加入觸碰事件
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    @IBAction func btnToSahre(sender: AnyObject) {
        //注意這裡一定要把文字轉換為NSString
        activityViewController=UIActivityViewController(
            activityItems:[shareField.text as NSString],
            applicationActivities:nil)
        
        //一行搞定所有的分享Facebook，Twitter,iMessage...等
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    //取消鍵盤
    func DismissKeyboard(){
        view.endEditing(true)
    }
}

