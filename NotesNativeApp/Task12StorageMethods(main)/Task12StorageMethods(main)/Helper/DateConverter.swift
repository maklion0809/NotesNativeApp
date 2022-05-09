//
//  Date.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import UIKit

final class DateConverter {
    
    private let dateFormatter = DateFormatter()
    
    func dayOfWeek(date: Date) -> String {
        self.dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
    
    func date(shortDateString: String) -> Date? {
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: shortDateString)
    }
    
    func date(dateTimeString: String) -> Date? {
        self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: dateTimeString)
    }
    
    func timeString(from date: Date) -> String {
        self.dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from:date)
    }
    
    func numberAndMounth(date: Date) -> String {
        self.dateFormatter.dateFormat = "d MMM"
        
        return dateFormatter.string(from: date)
    }
    
    func isItToday(date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        return "Not today"
    }
}
