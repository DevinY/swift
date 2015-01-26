//
//  ViewController.swift
//  test
//
//  Created by Devin Yang on 2015/1/7.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var inputLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnTest(sender: AnyObject) {
        var slabe=inputLabel.text
        if slabe=="screen1"||slabe=="screen2" {
        self.performSegueWithIdentifier(slabe,sender:self)
        } else {
            infoLabel.text="Segue ID輸入錯誤"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

