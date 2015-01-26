//
//  ViewController.swift
//  UIPickerView
//
//  Created by Devin Yang on 2015/1/2.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var picker:UIPickerView!
    var picker1:UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker=UIPickerView()
        picker.dataSource=self
        //picker.center=view.center
        picker.frame=CGRect(x: 100, y: 100, width: 200, height: 10)
        view.addSubview(picker)
        picker!.delegate=self
        
        picker1=UIPickerView()
        picker1.dataSource=self
        picker1.frame=CGRect(x: 300, y: 100, width: 100, height: 10)
        view.addSubview(picker1)
        picker1!.delegate=self
    }
    //要有幾個欄位
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        if pickerView == picker{
            return 2
        }
        if pickerView == picker1{
            return 1
        }
        return 0
    }
    //從0開始的列數
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == picker && component == 0{
            return 10
        }
        if pickerView == picker && component == 1{
            return 12
        }
        if pickerView == picker1{
            return 31
        }
        return 0
    }
 
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //row初始是0
        if component==0 && pickerView==picker {
            return "\(row+2014)"
        }
        return "\(row+1)"
    }
    
    //component等於是欄位
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch pickerView {
        case picker:
             println("左邊\(component)選擇了\(row)")
        case picker1:
             println("右邊選擇了\(row)")
        default:
            break
            
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

