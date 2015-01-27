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
   
    var tempCenter: UIView!
    var scrollView: UIScrollView!
    
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
        
        maxOWidth = 12 * oWidth  //總寬度
        scrollView.contentSize=CGSize(width: maxOWidth, height: oHeight)
        var maxOwidthStart = maxOWidth / 2
        
        //建立星期
        var weekdayUI = UIView(frame: CGRect(x: 0, y: 10, width: oWidth, height: 50))
        var weekdayObj=BuildCalendar(weekdayUI) //準備建日曆
        weekdayObj.buildWeekDay()
        
        view.addSubview(weekdayUI)
        
        for i in 1...6 {
            tempCenter = UIView(frame: CGRect(x: maxOwidthStart, y: oY, width: oWidth, height: oHeight))
            calendar = BuildCalendar(tempCenter) //準備建日曆
            var n = dObj.dateByAddingsMonths(i)
            var c = dObj.getCurrMonthComponent(nsdate: n) //取得十二個月前的月份
            calendar.buildCalendar(dObj.cToNsDate(c.firstDay))
            scrollView.addSubview(tempCenter)
            maxOwidthStart = maxOwidthStart +  oWidth
        }
        
        maxOwidthStart = maxOWidth / 2
        for i in 0...5 {
            maxOwidthStart = maxOwidthStart - oWidth
            tempCenter = UIView(frame: CGRect(x: maxOwidthStart, y: oY, width: oWidth, height: oHeight))
            calendar = BuildCalendar(tempCenter) //準備建日曆
            var n = dObj.dateBySubtractingMonths(i)
            var c = dObj.getCurrMonthComponent(nsdate: n) //取得十二個月前的月份
            calendar.buildCalendar(dObj.cToNsDate(c.firstDay))
            scrollView.delegate=self
                       scrollView.addSubview(tempCenter)
            
        }
        
        //啟動scrollView分頁這兩行很重要
        scrollView.frame=CGRectMake(0, 0, oWidth, oHeight)
        scrollView.pagingEnabled=true
        
        //設定ScrollView啟始位置
        scrollView.contentOffset.x=(maxOWidth / 2) - oWidth
        scrollView.alpha = 1.0
        
        //設定高 度
        scrollView.contentSize=CGSizeMake(maxOWidth,tempCenter.frame.height)
        scrollView.showsHorizontalScrollIndicator=false
        view.addSubview(scrollView)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        //scrollView.alpha = 0.50
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // scrollView.alpha = 1
        scrollView.contentSize=CGSizeMake(maxOWidth,tempCenter.frame.height)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //  scrollView.alpha = 1
    }
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
