//
//  NextWindow.swift
//  TableViewTest
//
//  Created by Devin Yang on 2015/1/1.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit
class NextWindow: UIViewController{
    
    @IBOutlet weak var lbInfo: UILabel!
    var msg=""
    override func viewDidLoad() {
super.viewDidLoad()
        lbInfo.text=msg
        let 向右滑動:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        向右滑動.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(向右滑動)
        
        let 向左滑動:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        向左滑動.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(向左滑動)
    }
 
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left{
            println("往左滑")
        }else{
            println("往右滑")
        }
    }
  
    func setLabel(msg:String){
        println(msg)
        self.msg=msg
    }
}
