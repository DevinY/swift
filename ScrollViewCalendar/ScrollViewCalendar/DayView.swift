//
//  test.swift
//  Calendar
//
//  Created by Devin Yang on 2015/1/20.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

protocol TouchDayView {
    func dayViewOnTouch(c:NSDateComponents)
}

class DayView: UIView, UIGestureRecognizerDelegate  {
    var dayLabel:UILabel!
    var lunarDayLabel:UILabel!
    var c:NSDateComponents!
    var delegate: TouchDayView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor=UIColor.whiteColor()
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        var labelWidth = (viewWidth/2)-(50/2)
        var labelHeight = (viewHeight/2)-(15/2)
    
        dayLabel = UILabel(frame:CGRect(x:labelWidth, y: labelHeight-6, width: 50, height: 15))
        dayLabel.textAlignment = .Center
        dayLabel.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        
        //dayLabel.textColor = UIColor(rgba: "#ccccccff")
        
        lunarDayLabel=UILabel(frame:CGRect(x:labelWidth, y:labelHeight+10, width: 50, height: 25))
        lunarDayLabel.textAlignment = .Center
        lunarDayLabel.font = UIFont.systemFontOfSize(10)
        lunarDayLabel.numberOfLines = 0
        lunarDayLabel.lineBreakMode = .ByWordWrapping
        
        //把自己加入觸碰手勢
        let recognizer = UITapGestureRecognizer(target: self, action:Selector("handleTap:"))
        recognizer.delegate = self
        self.addGestureRecognizer(recognizer)
        
        self.addSubview(dayLabel)
        self.addSubview(lunarDayLabel)
        
    }
    func handleTap(recognizer: UITapGestureRecognizer) {
        delegate?.dayViewOnTouch(self.c)
    }
    func setC(c:NSDateComponents){
        self.c=c
    }
    func setBackground(color:UIColor){
        self.backgroundColor=color
    }
    
    func setLabel(str:String){
        dayLabel.text=str
    }
    func setLunarLabel(str:String){
        lunarDayLabel.text=str
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
