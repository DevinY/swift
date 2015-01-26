//
//  ViewController.swift
//  TableViewTest/Users/devin/Desktop/TableViewTest/TableViewTest/AppDelegate.swift
//
//  Created by Devin Yang on 2014/12/31.
//  Copyright (c) 2014年 Devin Yang. All rights reserved.
//

import UIKit
//No need to declare Delegates if you set there property datasource and delegate in XIB
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var items = ["One","Two","資料"]
    var ii=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.separatorStyle=UITableViewCellSeparatorStyle.None
        items.append("額外的資料")
        self.myTableView.reloadData()
       
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    @IBAction func btnDelete(sender: AnyObject) {
        ii=sender.tag
       // println(sender.tag)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // var cell:UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var cell:myCell=self.myTableView.dequeueReusableCellWithIdentifier("cell") as myCell
        cell.Delete.tag=indexPath.row
       
        
        cell.textLabel?.text = self.items[indexPath.row]
      
        return cell
    }
    
    
//回傳true要執行 Segue回傳 false不執行
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
    //var rowindex=self.myTableView.indexPathForSelectedRow()
    var flag:Bool;
    switch ii {
    case 1:
        flag=true;
        
    case 2:
        // self.performSegueWithIdentifier("gogo",sender:self)
        flag=true;
        
    default:
        flag=true;
        
    }
    return flag;
    }
    //segue前準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var nextWindow: NextWindow=segue.destinationViewController as NextWindow
        nextWindow.setLabel(self.items[ii])
        println("prepareForSegue")
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         println("你選擇了Cell編號:\(indexPath.row)!")
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

