//
//  AppHelper.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/21/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation

class AppHelper {
    
    class func getNumberInKFormat(inpNumber: Double) -> String {
        if inpNumber >= 1000, inpNumber <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,inpNumber/1000).replacingOccurrences(of: ".0", with: "")
        }

        if inpNumber > 999999 {
            return String(format: "%.1fM", locale: Locale.current,inpNumber/1000000).replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f", locale: Locale.current,inpNumber)
    }
    
    class func getTime(strDate:String) -> String {
        var arrDate = strDate.split(separator: ".")
        let strFinalDate = arrDate[0].appending("Z")
        
        let format = DateFormatter()
        format.timeZone = .current
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let opDate = format.date(from: strFinalDate)
        let timezoneOffset =  TimeZone.current.secondsFromGMT()
        let epochDate = opDate!.timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        let timeZoneOffsetDate = Date(timeIntervalSince1970: timezoneEpochOffset)
        let strTime = self.getTimeAgo(dateToChanged: self.localTime(reqDate: timeZoneOffsetDate))
        return strTime
    }
    
    class func getTimeAgo(dateToChanged: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: dateToChanged, to: Date()) ?? "", locale: .current)
    }
    
    class func localTime(reqDate: Date) -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: reqDate))
        return Date(timeInterval: seconds, since: reqDate)
    }
}
