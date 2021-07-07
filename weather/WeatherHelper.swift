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
    let date: Date
    var hour: String
    
    init(time: Int64) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // hour hour, a = "am"/"pm"
        
        let epochTime = TimeInterval(time)
        date = Date(timeIntervalSince1970: epochTime)   // "Apr 16, 2015, 2:40 AM"
        hour = formatter.string(from: date) // "12 AM"
    }
}
