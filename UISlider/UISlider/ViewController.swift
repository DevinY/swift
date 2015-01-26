//
//  ViewController.swift
//  UISlider
//
//  Created by Devin Yang on 2015/1/2.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        slider=UISlider(frame:CGRect(x: 0, y: 0, width: 200, height: 23))
        slider.center=view.center //移至中間
        slider.minimumValue=0
        slider.maximumValue=100
        slider.value=slider.maximumValue/2.0
        //可自定圖檔顯示
        /*
        slider.setThumbImage(UIImage(named:"ThumbNormal"), forState: .Normal)
        slider.setThumbImage(UIImage(named: "ThumbHighlighted"), forState: .Highlighted)
        */
        
        //加入事件
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        view.addSubview(slider)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func sliderValueChanged(slider:UISlider){
        println("新的值:\(slider.value)")
    }
}

