//
//  ViewController.swift
//  ScrollViewCalendar
//
//  Created by Devin Yang on 2015/1/26.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     var c1:CalendarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        c1=CalendarViewController(nibName:"CalendarViewController",bundle:nil)
        self.addChildViewController(c1)
        c1.view.frame = CGRectMake(0, 30,self.view.frame.width, self.view.frame.height)
        view.addSubview(c1.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

