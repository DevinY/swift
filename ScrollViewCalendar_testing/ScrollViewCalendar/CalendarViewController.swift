//
//  CalendarViewController.swift
//  SwipeCalendar
//
//  Created by Devin Yang on 2015/1/25.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import UIKit


class CalendarViewController: UIViewController,UIScrollViewDelegate {
    var dObj:DCalendar!
    var calendar:BuildCalendar!
    var maxOWidth:CGFloat!
    var oWidth:CGFloat!
    var oHeight:CGFloat!
    var oX:CGFloat!
    var oY:CGFloat!
    var oRX:CGFloat!//右邊的佔存
    var start:CGFloat!
    var end:CGFloat!
    
    var tempCenter: UIView!
    var scrollView: UIScrollView!
    var currMonthIndex:NSDateComponents! //目前月份索引
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        oWidth = screenWidth     //畫面寬度
        oHeight = 380
        oX = 0.0
        oY = 60 //預設的高度
        oRX=oWidth
        
        dObj = DCalendar()
        
        //建立日曆
        scrollView = UIScrollView(frame: view.bounds)
        
        maxOWidth = 3 * oWidth  //總寬度
        scrollView.contentSize=CGSize(width: maxOWidth, height: oHeight)
        var maxOwidthStart = maxOWidth
        
        //建立星期
        var weekdayUI = UIView(frame: CGRect(x: 0, y: 10, width: oWidth, height: 50))
        var weekdayObj=BuildCalendar(weekdayUI) //準備建日曆
        weekdayObj.buildWeekDay()
        view.addSubview(weekdayUI)
        //中間0
        tempCenter = UIView(frame: CGRect(x: oWidth, y: oY, width: oWidth, height: oHeight))
        calendar = BuildCalendar(tempCenter) //準備建日曆
        var cn = dObj.dateByAddingsMonths(0)
        var cc = dObj.getCurrMonthComponent(nsdate: cn) //取得十二個月前的月份
        calendar.buildCalendar(dObj.cToNsDate(cc.firstDay))
        scrollView.addSubview(tempCenter)
        //右邊1
        tempCenter = UIView(frame: CGRect(x: oWidth*2, y: oY, width: oWidth, height: oHeight))
        calendar = BuildCalendar(tempCenter) //準備建日曆
        var n = dObj.dateByAddingsMonths(1)
        var c = dObj.getCurrMonthComponent(nsdate: n) //取得十二個月前的月份
        calendar.buildCalendar(dObj.cToNsDate(c.firstDay))
        scrollView.addSubview(tempCenter)
        //maxOwidthStart = maxOwidthStart +  oWidth
        //左邊2
        tempCenter = UIView(frame: CGRect(x: 0, y: oY, width: oWidth, height: oHeight))
        calendar = BuildCalendar(tempCenter) //傳入UIView準備建日曆
        var ln = dObj.dateBySubtractingMonths(1)
        var lc = dObj.getCurrMonthComponent(nsdate: ln) //取得十二個月前的月份
        calendar.buildCalendar(dObj.cToNsDate(lc.firstDay))
        scrollView.delegate=self
        scrollView.addSubview(tempCenter)
        
        
        //啟動scrollView分頁這兩行很重要
        scrollView.frame=CGRectMake(0, 0, oWidth, oHeight)
        scrollView.pagingEnabled=true
        
        //設定ScrollView啟始位置
        scrollView.contentOffset.x = oWidth
        scrollView.alpha = 1.0
        
        //設定高 度
        scrollView.contentSize=CGSizeMake(maxOWidth,tempCenter.frame.height)
        scrollView.showsHorizontalScrollIndicator=false
        view.addSubview(scrollView)
        
    }
    func createNewCalendar(){
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView){
        //scrollView.alpha = 0.50
        // println("scrollViewDidScroll")
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //println(scrollView.contentOffset.x)
        
        switch scrollView.contentOffset.x {
        case oWidth * 2:
            println("最右")
            var r = scrollView.subviews[1] as UIView
            var m = scrollView.subviews[0] as UIView
            var l = scrollView.subviews[2] as UIView
            
            var dv = r.subviews[10] as DayView //目前月份
            var fd = dObj.string("\(dv.c.year)-\(dv.c.month)-1") //目前月份的第一天
            
            m.frame.origin.x=0
            scrollView.insertSubview(m, atIndex: 2)
            r.frame.origin.x=oWidth
            scrollView.insertSubview(r, atIndex: 0)
            l.frame.origin.x=oWidth*2
            scrollView.insertSubview(l, atIndex: 1)
            scrollView.contentOffset.x = oWidth
            
            calendar = BuildCalendar(l) //傳入UIView準備建日曆
            var nd=dObj.getNextMonthByNsdate(fd)
            calendar.buildCalendar(dObj.cToNsDate(nd))
            
            
        case 0.0:
            println("最左")
            
            var r = scrollView.subviews[1] as UIView
            var m = scrollView.subviews[0] as UIView
            var l = scrollView.subviews[2] as UIView
            
            var dv = l.subviews[10] as DayView //目前月份
            var fd = dObj.string("\(dv.c.year)-\(dv.c.month)-1") //目前月份的第一天
            
            l.frame.origin.x=oWidth
            scrollView.insertSubview(l, atIndex: 0)
            scrollView.contentOffset.x = oWidth
            
            m.frame.origin.x=oWidth*2
            scrollView.insertSubview(m, atIndex: 1)
            
            r.frame.origin.x=0
            scrollView.insertSubview(r, atIndex: 2)
            
            calendar = BuildCalendar(r) //傳入UIView準備建日曆
            var nd=dObj.getPreMonthByNsdate(fd)
            println("新左邊:\(nd.year)-\(nd.month)-\(nd.day)")
            calendar.buildCalendar(dObj.cToNsDate(nd))
            
            
        default:
            println("中間")
            var dv = (scrollView.subviews[1].subviews[8]) as DayView
            println("month:\(dv.c.month)")
            
        }
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        println("scrollViewWillBeginDragging")
        start = scrollView.contentOffset.x;
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        println("scrollViewDidEndDragging")
         end = scrollView.contentOffset.x;
        
    }
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
        println("scrollViewDidScrollToTop")
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        println("scrollViewWillBeginDecelerating")
        var diff = end-start;
        if diff > 0 {
        }else{
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //這裡要建下月的資料
        println("scrollViewWillEndDragging")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
