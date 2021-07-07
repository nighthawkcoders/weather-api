//
//  Icon.swift
//  weather
//
//  Created by Michael Hayes on 7/1/21.
//

import Foundation

enum WeatherIcon {
    // case 
}

struct ConvertDate {
    var formatter = ISO8601DateFormatter()
    let date: Date
    let calendarReference: Calendar = Calendar.current // reference to extract hour
    var hourCalendar: Int // method 1 for hour extraction
    var hourFormatter: String // method 2 for hour extraction
    
    init() {
        let isoDateString = "2021-06-30T13:00:00-07:00"//"2017-01-23T10:12:31.484Z"
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        date = formatter.date(from: isoDateString) ?? Date.distantFuture
        hourCalendar = calendarReference.component(.hour, from: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
        hourFormatter = formatter.string(from: date) // "12 AM"
    }
}
