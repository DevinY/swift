//
//  ViewController.swift
//  test
//
//  Created by Devin Yang on 2015/1/16.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var rightViewController:UIViewController!
    var flag=false
    override func viewDidLoad() {
        super.viewDidLoad()
        rightViewController = storyboard?.instantiateViewControllerWithIdentifier("rightview") as UIViewController
        self.addChildViewController(rightViewController)
        rightViewController.view.frame.origin.x=self.view.frame.width
        self.view.addSubview(rightViewController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTest(sender: AnyObject) {
         self.flag = self.flag ? false : true
        UIView.animateWithDuration(2.0, animations: {Void->() in
           
            if self.flag {
                self.rightViewController.view.frame.origin.x = self.view.frame.width - (self.view.frame.width*2)
                println("right to left")
            } else {
                self.rightViewController.view.frame.origin.x = self.view.frame.width
                println("left to right")
            }
            
        })
        
    }

}

