//
//  ViewController.swift
//  UISwitch
//
//  Created by Devin Yang on 2015/1/2.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //宣告
    var 開關:UISwitch!
    
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        開關=UISwitch(frame:CGRect(x:100,y:100,width:0,height:0))
        
        開關.addTarget(self,
            action:"開關動作",
            forControlEvents: .ValueChanged)
        /*
        開關.tintColor=UIColor.redColor()
        開關.onTintColor=UIColor.brownColor()
        開關.thumbTintColor=UIColor.greenColor()
*/
        view.addSubview(開關)
        
        開關.setOn(true,animated:true)
        infoLabel.text="打開了"
        // Do any additional setup after loading the view, typically from a nib.
    }

    func 開關動作(){
        if 開關.on {
            infoLabel.text="打開了"
        }else{
            infoLabel.text="關閉"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

