//
//  BuildCalendar.swift
//  SwipeCalendar
//
//  Created by Devin Yang on 2015/1/25.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit

class BuildCalendar:TouchDayView,TouchCCView {
    let arrWeek:[String] = ["週日","週一","週二","週三","週四","週五","週六"]
    var dObj:DCalendar!
    var myCalendar:UIView!
    var parentController:UIViewController!
    var color:UIColor!
    var _alpha:CGFloat!
    var cgRect:CGRect!
    init(){
        
    }
    init(_ myCalendar:UIView){
        
        //建立日曆
        dObj=DCalendar()
        self.myCalendar=myCalendar
    }
    func setParentController(p:UIViewController){
        parentController=p
    }
    func buildWeekDay(){
        //  myCalendar.frame = parentController.view.frame
       
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        var wwidth=CGFloat(myCalendar.frame.width/7)
        var wheight=wwidth
        //iPhone 5s 需加長
        
        if screenWidth == 320.0 {
            wheight+=10
        }
        if screenWidth > 320.0 {
            wheight-=6
        }
        
        var dx=0
        var dy=0
        for item in 0...6{
            var dd:DayView = createDayView(dvX: CGFloat(dx) * CGFloat(wwidth),dvY: CGFloat(dy) * CGFloat(wheight-20),height: wwidth,width: wheight) as DayView
            dd.setLabel(arrWeek[item])
            dd.dayLabel.font = UIFont.boldSystemFontOfSize(14)
            dd.dayLabel.textColor=UIColor(rgba: "#000000")
            dd.tag=0
            myCalendar.addSubview(dd)
            ++dx
        }
       
    }
    func buildCalendar(_ d:NSDate=NSDate())->DCalendar{
        self.clearCalendar()
        var currMonth=dObj.getCurrMonthComponent(nsdate: d)
        var arrPreMonth=currMonth.month_pds
        var arrCurrMonth=currMonth.month
        var arrNextMonth=currMonth.month_lds
        var month = arrPreMonth + arrCurrMonth + arrNextMonth  //組合三個Array
        /*
        var wwidth = CGFloat(self.view.frame.width/7) //除以七取得星期寬度
        var wheight = wwidth
        */
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        //iPhone 6 plus:414, iPhone 6:375, iPhone 5s:320
        
        
        //  myCalendar.frame = parentController.view.frame
        var wwidth=CGFloat(myCalendar.frame.width/7)
        var wheight=wwidth
        //iPhone 5s 需加長
        if screenWidth == 320.0 {
            wheight+=10
        }
        if screenWidth > 320.0 {
            wheight-=6
        }
        //日曆迴圈
        var dx=0
        var dy=0
        /*
        for item in 0...6{
            var dayView:DayView = createDayView(dvX: CGFloat(dx) * CGFloat(wwidth),dvY: CGFloat(dy) * CGFloat(wheight-20),height: wwidth,width: wheight) as DayView
            dayView.setLabel(arrWeek[item])
            dayView.dayLabel.font = UIFont.boldSystemFontOfSize(14)
            dayView.dayLabel.textColor=UIColor(rgba: "#000000")
            dayView.tag=0
            myCalendar.addSubview(dayView)
            ++dx
        }
        
        dx=0
        dy=1
*/
        
        
        
        for item in month {
            
            var dayView:DayView = createDayView(dvX: CGFloat(dx) * CGFloat(wwidth),dvY: CGFloat(dy) * CGFloat(wheight)-20,height: wwidth,width: wheight) as DayView
            dayView.tag=1
            dayView.setC(item)
            dayView.delegate=self
            
            
            var cirdayView:CVCircleView = CVCircleView(frame: dayView.frame, color: UIColor(rgba: "#6600CC"), _alpha: 0.4)
            cirdayView.c=item
            
            cirdayView.delegate=self
            
            switch item.weekday {
            case 1:
                dayView.dayLabel.textColor=UIColor.redColor()
            case 7:
                dayView.dayLabel.textColor=UIColor(rgba: "#80b280")
            default:
                dayView.dayLabel.textColor=UIColor.blackColor()
            }
            
            cirdayView.setLabel("\(item.day)")
            cirdayView.dayLabel.textColor=UIColor.blackColor().colorWithAlphaComponent(1)
            
            dayView.setLabel("\(item.day)")
            
            var luObj = dObj.cToLunarDateString(item)
            switch luObj.lu_type {
            case 1:
                dayView.lunarDayLabel.textColor=UIColor.redColor()
                cirdayView.lunarDayLabel.textColor=UIColor.redColor()
            case 2:
                
                dayView.lunarDayLabel.textColor=UIColor(rgba: "#0000cc")
                cirdayView.lunarDayLabel.textColor=UIColor(rgba: "#0000cc")
            default:
                true
            }
            
            dayView.setLunarLabel("\(luObj.lu_day)")
            cirdayView.setLunarLabel("\(luObj.lu_day)")
            
            
            var todayC=dObj.today()
            var today=dObj.cToNsDate(todayC)
            if today.compare(dObj.cToNsDate(item)) == NSComparisonResult.OrderedSame {
                cirdayView.lunarDayLabel.textColor=UIColor.whiteColor()
                cirdayView.dayLabel.textColor=UIColor.whiteColor()
                myCalendar.addSubview(cirdayView)
            }else{
                myCalendar.addSubview(dayView)
            }
            
            
            var currMonth=dObj.getCurrMonth()
            //星期日一律設定紅色字
            if item.weekday == 1 {
                dayView.dayLabel.textColor=UIColor.redColor()
            }
            //非本月時
            if currMonth != item.month {
                dayView.dayLabel.textColor=UIColor(rgba:"#cdcdcdcc")
                dayView.lunarDayLabel.textColor=UIColor(rgba:"#cdcdcdcc")
                
                switch item.weekday {
                case 1:
                    dayView.dayLabel.textColor=UIColor.redColor().colorWithAlphaComponent(0.3)
                case 7:
                    dayView.dayLabel.textColor=UIColor(rgba: "#80b280").colorWithAlphaComponent(0.3)
                    // dayView.dayLabel.textColor=UIColor(rgba: "#80b280").colorWithAlphaComponent(0.5)
                default:
                    true
                    // dayView.dayLabel.textColor=UIColor.grayColor().colorWithAlphaComponent(0.5)
                }
                
                //dayView.setBackground(UIColor.grayColor().colorWithAlphaComponent(0.2))
            }
            
            ++dx
            if dx == 7 {
                dx = 0
                ++dy
            }
        }
        return dObj
    }
    func clearCalendar(){
        for sview in myCalendar.subviews {
            sview.removeFromSuperview()
        }
    }
    func dayViewOnTouch(c:NSDateComponents) {
        println("\(c.year)-\(c.month)-\(c.day)")
        println("touch dayView")
    }
    func createDayView(dvX:CGFloat=0,dvY:CGFloat=20.0, height:CGFloat,width:CGFloat )->DayView{
        var dayView:DayView=DayView(frame: CGRectMake(dvX, dvY, height, width)) as DayView
        return dayView
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
