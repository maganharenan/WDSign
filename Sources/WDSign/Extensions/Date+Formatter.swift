//
//  Date+Formatter.swift
//  
//
//  Created by Renan Maganha on 26/07/21.
//

import Foundation

extension Date {
    
    init(iso: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en")
        formatter.isLenient = true
        self = formatter.date(from: iso)!
    }
    
    init(isoHHmm: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en")
        formatter.isLenient = true
        self = formatter.date(from: isoHHmm)!
    }
    
    func toString(_ format: String = "dd-MM-yyyy HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        formatter.isLenient = true
        let dateString = formatter.string(from: self as Date)
        
        return dateString
    }
    
    func toStringHHmm(_ format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        let dateString = formatter.string(from: self as Date)
        
        return dateString
    }
    
    func toStringHHmmss(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en")
        let dateString = formatter.string(from: self as Date)
        
        return dateString
    }
    
    init(bySettingHHmm time: String) {
        let timeParts = time.components(separatedBy: ":")
        self = Calendar.current.date(bySettingHour: Int(timeParts[0])!, minute: Int(timeParts[1])!, second: 0, of: Date())!
    }
    
    func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }

    func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func weekday() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    static func datesBetween(startDate: Date, endDate: Date) -> [Date] {
        
        var dates = [Date]()
        var date = startDate
        
        while date <= endDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        
        return dates
    }
    
    static func daysBetween(startDate: Date, endDate: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
    }
    
    
    public var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return sunday
    }

    
    public var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
