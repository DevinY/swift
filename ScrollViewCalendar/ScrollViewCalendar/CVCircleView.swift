//
//  CVCircleView.swift
//  CVCalendar
//
//  Created by E. Mozharovsky on 12/27/14.
//  Copyright (c) 2014 GameApp. All rights reserved.
//

import UIKit
protocol TouchCCView {
    func dayViewOnTouch(c:NSDateComponents)
}

class CVCircleView: UIView,UIGestureRecognizerDelegate {
    
    let color: UIColor?
    let _alpha: CGFloat?
     var dayLabel:UILabel!
     var lunarDayLabel:UILabel!
     var c:NSDateComponents!
    var delegate: TouchCCView?
    init(frame: CGRect, color: UIColor, _alpha: CGFloat) {
        super.init(frame: frame)
        
        self.color = color
        self._alpha = _alpha
        self.alpha = _alpha
        
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        var labelWidth = (viewWidth/2)-(50/2)
        var labelHeight = (viewHeight/2)-(15/2)

        self.backgroundColor = .clearColor()
        dayLabel=UILabel(frame:CGRect(x:labelWidth, y: labelHeight-6, width: 50, height: 15))
        dayLabel.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        dayLabel.textAlignment = .Center
        
        
        lunarDayLabel=UILabel(frame:CGRect(x:labelWidth, y: labelHeight+10, width: 50, height: 15))
        lunarDayLabel.textAlignment = .Center
        lunarDayLabel.font = UIFont.boldSystemFontOfSize(10)
       
        let recognizer = UITapGestureRecognizer(target: self, action:Selector("handleTap:"))
        recognizer.delegate = self
        self.addGestureRecognizer(recognizer)
       
       
        self.addSubview(dayLabel)
        self.addSubview(lunarDayLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func handleTap(recognizer: UITapGestureRecognizer) {
        delegate?.dayViewOnTouch(self.c)
    }
    func setLabel(str:String){
        dayLabel.text=str
    }
    func setLunarLabel(str:String){
        lunarDayLabel.text=str
    }
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        // Draw
        CGContextSetFillColorWithColor(context, self.color!.CGColor)
        CGContextSetStrokeColorWithColor(context, self.color!.CGColor)
        CGContextDrawPath(context, kCGPathFillStroke)
    }
}
