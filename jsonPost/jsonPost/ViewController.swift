//
//  ViewController.swift
//  jsonPost
//
//  Created by Devin Yang on 2015/2/1.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var urlToRequest = "http://www.ccc.tc/test.php"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSend(sender: AnyObject) {
        // create the request & response
      
        var request = NSMutableURLRequest(URL: NSURL(string: urlToRequest)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        // create some JSON data and configure the request
        var varname="TTTT";
        let jsonString = "json=[{\"str\":\"\(varname)\",\"num\":1},{\"str\":\"Goodbye\",\"num\":99}]"
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // send the request
        var data:NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)?
       
        // look at the response
        if let httpResponse = response as? NSHTTPURLResponse {
            println("HTTP response: \(httpResponse.statusCode)")
            /* 抓網頁回傳的文字 */
            var body:String = NSString(data: data, encoding: NSUTF8StringEncoding)!
            //println(body)
            
            
            var arrData = JSONParseArray(body)
            for elem:AnyObject in arrData {
                let str = elem["str"] as String
                 println("str:\(str)")
                let test:NSDictionary = elem["test"] as NSDictionary
                println(test["stat"] as String)
                println(test["sub"] as String)
                //println("str:\(str)")
            }
        } else {
            println("No HTTP response")
        }
        
    }
    //===========JSON功能================
    func JSONParseArray(jsonString: String) -> [AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
                return array
            }
        }
        return [AnyObject]()
    }
    
    
    func JSONParseDictionary(jsonString: String) -> [String: AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [String: AnyObject] {
                return dictionary
            }
        }
        return [String: AnyObject]()
    }

}

