//
//  ViewController.swift
//  UIAlertActionController
//
//  Created by Devin Yang on 2015/1/2.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var controllerAlert1:UIAlertController?
    var controllerAlert2:UIAlertController?
    var controllerAS:UIAlertController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化警告
        controllerAlert1=UIAlertController(title: "這是主題",message:"這是顯示的內容",preferredStyle:.Alert)
        
        
        //動作功能
        let action1=UIAlertAction(title:"確認",style: UIAlertActionStyle.Default,
            handler:{
                (paramAction:UIAlertAction!) in
                    println("壓了確認鈕了")
            }
        )
        //加入動作
        controllerAlert1!.addAction(action1)
        
        //初始化警告
        controllerAlert2=UIAlertController(title: "這是主題",message:"這是顯示的內容",preferredStyle:.Alert)
        //加入文字框
        controllerAlert2!.addTextFieldWithConfigurationHandler({
            (textField:UITextField!) in
            textField.placeholder="請輸入您的名字"
        })
        //新增動作二
        let action2=UIAlertAction(title:"確認",style: UIAlertActionStyle.Default,
            handler:{[weak self]
                (paramAction:UIAlertAction!) in
                if let textFields=self!.controllerAlert2?.textFields{
                    let theTextFields = textFields as [UITextField]
                    let userName=theTextFields[0].text
                    println("你的名字是\(userName)")
                }
        })
        //加入動作
        controllerAlert2!.addAction(action2)
        
        //初始化ActionSheet
        controllerAS=UIAlertController(title: "要做什麼事",message:"請選擇你要進行的動作",preferredStyle:.ActionSheet)
        //動作一
        let actionOne=UIAlertAction(
            title: "動作一",
            style:UIAlertActionStyle.Default,
            handler:
            {(paramAction:UIAlertAction!) in
                /*寫動作程式在這*/
        })
        //動作二
        let actionTwo=UIAlertAction(
            title: "動作二",
            style:UIAlertActionStyle.Default,
            handler:
            {(paramAction:UIAlertAction!) in
                /*寫動作程式在這*/
        })
        //動作三
        let actionThree=UIAlertAction(
            title: "刪除",
            style:UIAlertActionStyle.Destructive,
            handler:
            {(paramAction:UIAlertAction!) in
                /*寫動作程式在這*/
        })
        //建立好動作後，我們把他加入到controllerAS中
        controllerAS!.addAction(actionOne)
        controllerAS!.addAction(actionTwo)
        controllerAS!.addAction(actionThree)
    }
    @IBAction func btnAlert1(sender: AnyObject) {
         self.presentViewController(controllerAlert1!, animated: true, completion: nil)
    }
    
    @IBAction func btnAlert2(sender: AnyObject) {
        self.presentViewController(controllerAlert2!, animated: true, completion: nil)
    }
    
    @IBAction func btnActionSheet(sender: AnyObject) {
        self.presentViewController(controllerAS!, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

