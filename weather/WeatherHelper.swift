//
//  Icon.swift
//  weather
//
//  Created by Michael Hayes on 7/1/21.
//

import Foundation

enum WeatherIcon: String {
    case sunny = "Sunny"
    case mostlySunny = "Mostly Sunny"
    case partlySunny = "Partly Sunny"
    case intermittentClouds = "Intermittent Clouds"
    case hazySunshine = "Hazy Sunshine"
    case mostlyCloudy = "Mostly Cloudly"
}

struct ConvertDate {
    let date: Date
    var hour: String
    
    init(time: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a" // hour hour, a = "am"/"pm"
        
        let epochTime = TimeInterval(time)
        date = Date(timeIntervalSince1970: epochTime)   // "Apr 16, 2015, 2:40 AM"
        hour = formatter.string(from: date) // "12 AM"
    }
}
