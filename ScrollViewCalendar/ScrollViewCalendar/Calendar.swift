//
//  Calendar.swift
//  Calendar
//
//  Created by Devin Yang on 2015/1/20.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

import Foundation
import UIkit

extension UIColor {
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (countElements(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

class DCalendar {
    // let componentFlags : NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .WeekCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit | .WeekdayCalendarUnit | .WeekdayOrdinalCalendarUnit;
    let componentFlags = NSCalendarUnit(UInt.max)
    let D_SECOND = 1
    let D_MINUTE = 60
    let D_HOUR = 3600
    let D_DAY = 86400
    let D_WEEK = 604800
    let D_YEAR = 31556926
    let formatter:NSDateFormatter!
    var calendar:NSCalendar!
    var calendarLunar:NSCalendar!
    var rocCalendar:NSCalendar!
    var lunarCalendar:NSCalendar!
    var year:Int
    var month:Int
    var day:Int
    var week:Int
    
    var lunar_year:String!
    var lunar_month:Int!
    var lunar_day:Int!
    var lunar_week:Int!
    var currMonthComponent:NSDateComponents!
    var currMonth:Int! //儲存CurrMonth設定的月份
    
    var lunarDic_year=[01:"甲子", 02:"乙丑", 03:"丙寅", 04:"丁卯", 05:"戊辰", 06:"己巳", 07:"庚午", 08:"辛未", 09:"壬申", 10:"癸酉", 11:"甲戌", 12:"乙亥", 13:"丙子", 14:"丁丑", 15:"戊寅", 16:"己卯", 17:"庚辰", 18:"辛巳", 19:"壬午", 20:"癸未", 21:"甲申", 22:"乙酉", 23:"丙戌", 24:"丁亥", 25:"戊子", 26:"己丑", 27:"庚寅", 28:"辛卯", 29:"壬辰", 30:"癸巳", 31:"甲午", 32:"乙未", 33:"丙申", 34:"丁酉", 35:"戊戌", 36:"己亥", 37:"庚子", 38:"辛丑", 39:"壬寅", 40:"癸卯", 41:"甲辰", 42:"乙巳", 43:"丙午", 44:"丁未", 45:"戊申", 46:"己酉", 47:"庚戌", 48:"辛亥", 49:"壬子", 50:"癸丑", 51:"甲寅", 52:"乙卯", 53:"丙辰", 54:"丁巳", 55:"戊午", 56:"己未", 57:"庚申", 58:"辛酉", 59:"壬戌", 60:"癸亥"]
    
    var dic_month=[1:"一月",2:"二月",3:"三月",4:"四月",5:"五月",6:"六月",7:"七月",8:"八月",9:"九月",10:"十月",11:"十一月",12:"十二月"]
    var lunarDic_month=[1:"正月",2:"杏月",3:"桃月",4:"陰月",5:"榴月",6:"荷月",7:"蘭月",8:"桂月",9:"菊月",10:"良月",11:"冬月",12:"獵月"]
    var lunarDic_day=[1:"初一",2:"初二",3:"初三",4:"初四",5:"初五",6:"初六",7:"初七",8:"初八",9:"初九",10:"初十",11:"十一",
        12:"十二",13:"十三",14:"十四",15:"十五",16:"十六",17:"十七",18:"十八",19:"十九",20:"廿十",21:"廿一",22:"廿二",23:"廿三",
        24:"廿四",25:"廿五",26:"廿六",27:"廿七",28:"廿八",29:"廿九",30:"三十"]
    
    
    init(){
        formatter = NSDateFormatter() //格式化日期
        formatter.dateFormat = "yyyy-MM-dd"
        // var dic:NSDictionary=NSLocale.componentsFromLocaleIdentifier(NSRepublicOfChinaCalendar)
        calendar = NSCalendar.currentCalendar()
        rocCalendar = NSCalendar(identifier: NSRepublicOfChinaCalendar) //國曆
        lunarCalendar =  NSCalendar(identifier: NSChineseCalendar)      //農曆
        //  NSLocale.currentLocale().objectForKey(objectForKey: NSLocaleCalendar)
        
        
        var c=calendar.components(componentFlags, fromDate: NSDate())
        year  =  c.year
        month =  c.month
        day =  c.day
        week = c.weekday
    }
    
    func now(daynum:Int=0)->NSDate{
        if daynum > 0 {
            return self.dateByAddingsDays(daynum)
        }
        if daynum < 0 {
            return self.dateBySubtractingDays(abs(daynum))
        }
        return NSDate()
    }
    func today()->NSDateComponents{
        var c=calendar.components(componentFlags, fromDate: NSDate())
        return c
    }
    
    
    //取得當月的第一天所有資料
    func getCurrMonthComponent(nsdate:NSDate=NSDate())->(firstDay:NSDateComponents,lastDay:NSDateComponents,month:[NSDateComponents],month_pds:[NSDateComponents],month_lds:[NSDateComponents]){
        var arrMonth = [NSDateComponents]() //宣告陣列
        var arrPreMonthLastDays = [NSDateComponents]() //宣告陣列
        var arrNextMonthFirsDatys = [NSDateComponents]() //宣告陣列
        var tempDate:NSDate!
        var tempComp:NSDateComponents!
        
        var c = calendar.components(componentFlags, fromDate: nsdate) //透過傳入的nsdate，取得當天的資料或是指定的資料
        self.currMonth=c.month //儲存目前月份
        
        
        var firstdayofmonth:NSDate! = formatter.dateFromString("\(c.year)-\(c.month)-1") //取月份第一天的資料
        // var firstdayofmonth:NSDate! = formatter.dateFromString("\(c.year)-3-1") //取月份第一天的資料
        var firstDay=calendar.components(componentFlags, fromDate: firstdayofmonth) //NSDate轉Calendar component(當月第一天的components)
        
        self.currMonthComponent=firstDay //把第一天的資料存到物件中保存
        
        var firstdayofnextMonth=self.getNextMonthComponent() //取得下月的第一天資料
        var firstdayofnextMonthNd=formatter.dateFromString(self.cToDayString(firstdayofnextMonth)) //轉NSDate
        var lastdayofmonth = firstdayofnextMonthNd!.dateByAddingTimeInterval(-Double(D_DAY)) //取得這個月的最後一天
        var lastDay=calendar.components(componentFlags, fromDate: lastdayofmonth) //NSDate轉Calendar component(當月最後一天的components)
        
        arrMonth=self.loop(firstdayofmonth) //從那個月的第一天開始循環
        //weekday的規則禮拜日是1...到禮拜六是7
        //如果第一天不等於禮拜一，抓出上月的日期.
        var weekLeft = 7 - (8 - firstDay.weekday) //抓出每月第一天的左邊有幾天，如果是4，就抓出上月的最後四天日期
        //抓出上個月的最後幾的天數存到Array中.
        if weekLeft != 0 {
            for i in 1...weekLeft {
                tempDate = self.dateBySubtractingDays(i, date: firstdayofmonth)
                tempComp = calendar.components(componentFlags, fromDate: tempDate)
                arrPreMonthLastDays.append(tempComp)
                
            }
            arrPreMonthLastDays=reverse(arrPreMonthLastDays)
        }
        var weekRight = 7 - lastDay.weekday //抓出每月最後一天的右邊有幾天，如果最後一天是禮拜四，那麼右邊就有下月的兩天在禮拜5跟6
        if weekRight != 0 {
            //抓出下月前幾天的天數存入Array中
            for i in 1...weekRight {
                tempDate = self.dateByAddingsDays(i, date: lastdayofmonth)
                tempComp = calendar.components(componentFlags, fromDate: tempDate)
                arrNextMonthFirsDatys.append(tempComp)
            }
        }
        return (firstDay,lastDay, arrMonth,arrPreMonthLastDays,arrNextMonthFirsDatys)
    }
    func getCurrMonth()->Int{
        return self.currMonth
    }
    //以CurrentMonthComponent為基準，取得上月第一天所有資料
    func getPreMonthComponent()->NSDateComponents{
        var firstDayObj=self.string(cToDayString(currMonthComponent))
        var preDate=firstDayObj.dateByAddingTimeInterval(-Double(D_DAY))
        var c=calendar.components(componentFlags, fromDate: preDate)
        var firstdayofmonth=formatter.dateFromString("\(c.year)-\(c.month)-01")!
        c=calendar.components(componentFlags, fromDate: firstdayofmonth)
        
        return c
    }
    //目前月份減多少月
    func getMonth(n:Int){
        
    }
    //以CurrentMonthComponent為基準，取得下一月第一天所有資料
    func getNextMonthComponent()->NSDateComponents{
        var cmc=self.currMonthComponent
        //取下月第一天的資料
        var newMonth = cmc.month+1
        var newDay:Int=1
        var newYear:Int=cmc.year
        switch(newMonth){
        case 13:
            ++newYear
            newMonth = 1
            newDay = 1
        default:
            newDay=1
        }
        var firstDayOfNextMonth = formatter.dateFromString("\(newYear)-\(newMonth)-\(newDay)")! //下月第一天
        var c=calendar.components(componentFlags, fromDate: firstDayOfNextMonth)
        return c
    }
    //傳西元日曆nsdate轉農曆components
    func lunar(nsdate:NSDate)->NSDateComponents{
        var c=lunarCalendar.components(componentFlags, fromDate: nsdate)
        return c
    }
    func cLunar(c:NSDateComponents)->NSDateComponents{
        var nsdate=formatter.dateFromString("\(c.year)-\(c.month)-\(c.day)")
        var c=lunarCalendar.components(componentFlags, fromDate: nsdate!)
        return c
    }
    //傳西元日曆的components取得農曆年月日
    //lu_type: 0: 一般 1: 二十四節氣, 2: 節日
    func cToLunarDateString(c:NSDateComponents)->(lu_year:String,lu_month:String,lu_day:String,lu_type:Int){
        var lu_type=0
        var nsdate=formatter.dateFromString("\(c.year)-\(c.month)-\(c.day)")
        
        //取農曆的年月日
        var lu=lunar(nsdate!)
        var lu_year:String! = lunarDic_year[lu.year]
        var lu_month:String! = lunarDic_month[lu.month]
        var lu_day:String! = lunarDic_day[lu.day]
        
        //傳入國曆的年月，回傳農曆的二十四節氣
        var solar = self.solarTerms(c)
        if solar.solarTerm != "" {
            lu_day=solar.solarTerm
            lu_type = 1
        }
       
        if lu.leapMonth == false {
       
        switch (lu.month,lu.day) {
        case (1,1):
            lu_type = 2
            lu_day = "春節"
        case (1,2):
            lu_type = 2
            lu_day = "回娘家"
        case (1,9):
            lu_type = 2
            lu_day="天公生"
        case (1,15):
            lu_type = 2
            lu_day="元宵節"
        case (2,2):
            lu_type = 2
            lu_day = "土地公生日"
        case (2,19):
            lu_type = 2
            lu_day = "觀世音菩薩誕辰"
        case (3,23):
            lu_type = 2
            lu_day = "媽祖生"
        case (4,8):
            lu_type = 2
            lu_day = "浴佛節"
        case (5,5):
            lu_type = 2
            lu_day = "端午節"
        case (7,1):
            lu_type = 2
            lu_day = "開鬼門"
        case (7,7):
            lu_type = 2
            lu_day = "七夕情人節"
        case (7,30):
            lu_type = 2
            lu_day = "關鬼門"
        case (8,15):
            lu_type = 2
            lu_day = "中秋節"
        case (9,9):
            lu_type = 2
            lu_day="重陽節"
        case (12,8):
            lu_type = 2
            lu_day = "臘八節"
        case (12,24):
            lu_type = 2
            lu_day = "送神"
        default:
            true
        }
        }
        return (lu_year,lu_month,lu_day,lu_type)
    }
    //轉國曆
    func roc(nsdate:NSDate)->NSDateComponents{
        var c=rocCalendar.components(componentFlags, fromDate: nsdate)
        return c
    }
    func cRoc(c:NSDateComponents)->NSDateComponents{
        var nsdate=formatter.dateFromString("\(c.year)-\(c.month)-\(c.day)")
        var c=rocCalendar.components(componentFlags, fromDate: nsdate!)
        return c
    }
    //NSDate轉NSDateComponents
    func nToComponents(nsdate:NSDate)->NSDateComponents{
        var c=calendar.components(componentFlags, fromDate: nsdate)
        return c
    }
    
    //component轉成String
    func cToDayString(c:NSDateComponents)->String{
        return "\(c.year)-\(c.month)-\(c.day)"
    }
    func cToNsDate(c:NSDateComponents)->NSDate{
        return formatter.dateFromString("\(c.year)-\(c.month)-\(c.day)")!
    }
    //取得本年的月份的第一天
    func getThisYearMonth(month:Int)->NSDate {
        self.month=month
        return formatter.dateFromString("\(year)-\(month)-01")!
    }
    //取得本月第一天
    func firstDay()->NSDateComponents{
        var d=formatter.dateFromString("\(year)-\(month)-01")!
        var c=calendar.components(componentFlags, fromDate: d)
        return c
    }
    //取得本月份最後天的字串
    func lastDay(yearInt:Int=0,monthInt:Int=0)->NSDateComponents{
        var cmc=calendar.components(componentFlags, fromDate: NSDate()) //今天
        var newYear:Int!
        var newMonth:Int!
        var newDay:Int=1
        println(monthInt)
        if yearInt > 0 {
            newMonth = monthInt+1
            newYear = yearInt
        }else{
            newYear = cmc.year
            newMonth = cmc.month+1
        }
        switch(newMonth){
        case 13:
            newYear=newYear+1
            newMonth = 1
            newDay = 1
        default:
            newDay=1
        }
        var firstDayOfNextMonth = formatter.dateFromString("\(newYear)-\(newMonth)-\(newDay)")! //下月第一天
        var currMonthEndDay=self.dateBySubtractingDays(1, date: firstDayOfNextMonth) //下月的第一天減一天就是本月的最後一天
        var c=calendar.components(componentFlags, fromDate: currMonthEndDay)
        return c
    }
    //循環日期
    func loop(firstDayObj:NSDate,weekOrdinal:Int=0)->[NSDateComponents]{
        var emptyArray = [NSDateComponents]()
        var newDate:NSDate!
        for d in 0...31 {
            var aTimeInterval = Double(D_DAY) * Double(d)
            var aTimeIntervalNext = Double(D_DAY) * Double(d) + Double(D_DAY)
            newDate = firstDayObj.dateByAddingTimeInterval(aTimeInterval)
            
            
            
            var c=calendar.components(componentFlags, fromDate: newDate)
            
            
            
            if weekOrdinal == c.weekdayOrdinal {
                emptyArray.append(c)
            }
            if weekOrdinal ==  0{
                emptyArray.append(c)
            }
            var newDateNext = firstDayObj.dateByAddingTimeInterval(aTimeIntervalNext)
            if !isSameMonthAsDate(newDate, bDate: newDateNext) {
                return emptyArray
            }
        }
        return emptyArray
    }
    
    //取得該月的最後一週所有日期
    func lastWeeksDays(c:NSDateComponents)->[NSDateComponents]{
        var arr=self.loop(self.cToNsDate(c))
        var arrLast=arr[arr.count-1] //取得components的最後一天
        var lastWeekOrdinal=arrLast.weekdayOrdinal //取得最後一天在第幾週
        return self.loop(self.cToNsDate(c),weekOrdinal: lastWeekOrdinal) //取得該月最後一週的天數
    }
    
    //今天加幾個月
    func dateByAddingsMonths(dYMonths:NSInteger) -> NSDate{
        var dateComponents = NSDateComponents();
        dateComponents.month = dYMonths;
        
        let newDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: NSDate(), options:nil);
        
        return newDate!;
        
    }
    func dateBySubtractingMonths(dYMonths:NSInteger) -> NSDate{
        return self.dateByAddingsMonths(dYMonths * -1);
    }

    //NSDate的移動
    func dateByAddingsDays(dDays:NSInteger,date:NSDate=NSDate()) -> NSDate{
        var dateComponents = NSDateComponents();
        dateComponents.day = dDays;
        
        let newDate = calendar.dateByAddingComponents(dateComponents, toDate: date, options:nil);
        
        return newDate!;
    }
    
    func dateBySubtractingDays(dDays:NSInteger,date:NSDate=NSDate()) -> NSDate{
        return self.dateByAddingsDays(dDays * -1,date:date);
    }
    //把日期字串改為NSDate
    func string(date:String)->NSDate{
        return formatter.dateFromString(date)!
    }
    //取得星期幾 0:禮拜天, 1~6
    func getWeek(date:NSDate)->Int{
        var week = calendar.component(.CalendarUnitWeekday, fromDate: date)
        return week-1
    }
    //取得日曆上第幾週.
    func getWeekOrdinal(date:NSDate)->Int{
        var weekOrdinal = calendar.component(.CalendarUnitWeekOfMonth, fromDate: date)
        return weekOrdinal
    }
    
    
    //是否是同一個月
    func isSameMonthAsDate(aDate:NSDate, bDate:NSDate) -> Bool
    {
        var components1 = calendar.components(componentFlags, fromDate: aDate);
        var components2 = calendar.components(componentFlags, fromDate: bDate);
        return ((components1.month == components2.month) &&
            (components1.year == components2.year));
    }
    
    //要傳國曆，回傳月及日
    func solarTerms(comp:NSDateComponents)->(month:Int,day:Int,solarTerm:String){
        var year=comp.year
        var date="\(comp.month)-\(comp.day)"
        var solar:[String:String]!
        switch(year){
        case 1901...2011:
            solar = ["1-6":"小寒","1-21":"大寒","2-4":"立春","2-19":"雨水","3-6":"驚蟄","3-21":"春分","4-5":"清明","4-20":"穀雨","5-5":"立夏","5-20":"小滿","6-6":"芒種","6-22":"夏至","7-7":"小暑","7-23":"大暑","8-8":"立秋","8-23":"處暑","9-8":"白露","9-23":"秋分","10-8":"寒露","10-24":"霜降","11-8":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2012:
            solar = ["1-6":"小寒","1-21":"大寒","2-4":"立春","2-19":"雨水","3-5":"驚蟄","3-20":"春分","4-4":"清明","4-20":"穀雨","5-5":"立夏","5-20":"小滿","6-5":"芒種","6-21":"夏至","7-7":"小暑","7-22":"大暑","8-7":"立秋","8-23":"處暑","9-7":"白露","9-22":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-21":"冬至"]
        case 2013:
            solar = ["1-5":"小寒","1-20":"大寒","2-4":"立春","2-18":"雨水","3-5":"驚蟄","3-20":"春分","4-4":"清明","4-20":"穀雨","5-5":"立夏","5-21":"小滿","6-5":"芒種","6-21":"夏至","7-7":"小暑","7-22":"大暑","8-7":"立秋","8-23":"處暑","9-7":"白露","9-22":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2014:
            solar = ["1-5":"小寒","1-20":"大寒","2-4":"立春","2-19":"雨水","3-6":"驚蟄","3-21":"春分","4-5":"清明","4-20":"穀雨","5-5":"立夏","5-21":"小滿","6-6":"芒種","6-21":"夏至","7-7":"小暑","7-23":"大暑","8-7":"立秋","8-23":"處暑","9-8":"白露","9-23":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2015:
            solar = ["1-6":"小寒","1-20":"大寒","2-4":"立春","2-19":"雨水","3-6":"驚蟄","3-21":"春分","4-5":"清明","4-20":"穀雨","5-5":"立夏","5-21":"小滿","6-6":"芒種","6-22":"夏至","7-7":"小暑","7-23":"大暑","8-8":"立秋","8-23":"處暑","9-8":"白露","9-23":"秋分","10-8":"寒露","10-24":"霜降","11-8":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2016:
            solar = ["1-6":"小寒","1-20":"大寒","2-4":"立春","2-19":"雨水","3-5":"驚蟄","3-20":"春分","4-4":"清明","4-19":"穀雨","5-5":"立夏","5-20":"小滿","6-5":"芒種","6-21":"夏至","7-7":"小暑","7-22":"大暑","8-7":"立秋","8-23":"處暑","9-7":"白露","9-22":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2017:
            solar = ["1-5":"小寒","1-20":"大寒","2-3":"立春","2-18":"雨水","3-5":"驚蟄","3-20":"春分","4-4":"清明","4-20":"穀雨","5-5":"立夏","5-21":"小滿","6-5":"芒種","6-21":"夏至","7-7":"小暑","7-22":"大暑","8-7":"立秋","8-23":"處暑","9-7":"白露","9-23":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2018:
            solar = ["1-5":"小寒","1-20":"大寒","2-4":"立春","2-19":"雨水","3-5":"驚蟄","3-21":"春分","4-5":"清明","4-20":"穀雨","5-5":"立夏","5-21":"小滿","6-5":"芒種","6-21":"夏至","7-7":"小暑","7-23":"大暑","8-7":"立秋","8-23":"處暑","9-8":"白露","9-23":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2019:
            solar = ["1-5":"小寒","1-20":"大寒","2-4":"立春","2-19":"雨水","3-6":"驚蟄","3-21":"春分","4-5":"清明","4-20":"穀雨","5-6":"立夏","5-21":"小滿","6-5":"芒種","6-21":"夏至","7-7":"小暑","7-23":"大暑","8-8":"立秋","8-23":"處暑","9-8":"白露","9-23":"秋分","10-8":"寒露","10-24":"霜降","11-8":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        case 2020:
            solar = ["1-6":"小寒","1-20":"大寒","2-4":"立春","2-19":"雨水","3-5":"驚蟄","3-20":"春分","4-5":"清明","4-19":"穀雨","5-5":"立夏","5-20":"小滿","6-5":"芒種","6-21":"夏至","7-6":"小暑","7-22":"大暑","8-7":"立秋","8-22":"處暑","9-8":"白露","9-23":"秋分","10-8":"寒露","10-23":"霜降","11-7":"立冬","11-22":"小雪","12-7":"大雪","12-22":"冬至"]
        default:
            true
            
        }
        var month:Int! = Regex("(\\d\\d?)-(\\d\\d?)").replace(date,"$1").toInt()
        var day:Int! = Regex("(\\d\\d?)-(\\d\\d?)").replace(date,"$2").toInt()
        if let solarTerm = solar[date] {
            return (month,day,solarTerm)
        }
        else
        {
            return (month,day,"")
        }
    }
    
}
