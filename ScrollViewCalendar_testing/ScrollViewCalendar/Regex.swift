//
//  Regex.swift
//  Calendar
//
//  Created by Devin Yang on 2015/1/24.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit
/*
使用方式
//透過pattern取字串開頭dog的字串
var test = Regex("^(dog)(.*)").replace("dogcat",rstr: "$1")

//透過pattern判斷是否符合ABCD
if Regex("\\w{4}").ismatch("ABCD") {
println("matches pattern")
}
*/
class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
    }
    func ismatch(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input)))
        return matches.count > 0
    }
    func replace(text:String,_ rstr:String)->String{
        var reg=NSRegularExpression(pattern: pattern, options:nil, error: nil)
        //有符合就進行replace，沒有就回傳空值
        if self.ismatch(text) {
            var tmpStr:String! = reg?.stringByReplacingMatchesInString(text, options: NSMatchingOptions(), range: NSMakeRange(0, countElements(text)), withTemplate: rstr)
            return tmpStr
        } else {
            return ""
        }
    }
}
