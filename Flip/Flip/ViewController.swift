//
//  ViewController.swift
//  Flip
//
//  Created by Devin Yang on 2015/1/14.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var front:UIViewController!
    var back:UIView!
    var VC:UIView!
    var isOpen=false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        front=storyboard?.instantiateViewControllerWithIdentifier("cc") as UIViewController
        self.addChildViewController(front)
        //前面
        front.view.backgroundColor=UIColor.brownColor()
        front.view.frame=CGRectMake(0,0, 300, 300)
        
        //背面
        back=UIView(frame: CGRectMake(0, 0, 300, 300))
        back.backgroundColor=UIColor.blackColor()
        
        VC=UIView(frame: CGRectMake(100, 100, 300, 300))
       self.roundCorners(.TopRight | .TopLeft | .BottomLeft | .BottomRight, radius: 10)
        
        //把兩個View加到個容器中，才能顯示翻轉的效果
        VC.addSubview(front.view)
        VC.addSubview(back)
       
        self.view.addSubview(VC)
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: VC.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        front.view.layer.mask = mask
        
        let mask1 = CAShapeLayer()
        mask1.path = path.CGPath
        back.layer.mask = mask1
        
        
    }
    @IBAction func btnTest(sender: AnyObject) {
        isOpen=isOpen ? false:true;
        if isOpen {
             UIView.transitionFromView(back, toView: front.view, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        }else{
             UIView.transitionFromView(front.view, toView: back, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        }
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

