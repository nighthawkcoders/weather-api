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

class weatherIcons {
    var weatherIcons: [String : String]
    
    // API return icon identifers match reference to the SF Symbols library
    init() {
        weatherIcons = [
            "Sunny": "sun.max.fill",
            "Mostly sunny": "cloud.sun.fill",
            "Partly sunny": "cloud.sun.fill",
            "Intermittent clouds": "cloud.sun.fill",
            "Hazy sunshine": "sun.haze.fill",
            "Mostly cloudy": "cloud.sun.fill",
            "Cloudy": "cloud.fill",
            "Dreary (Overcast)": "smoke.fill",
            "Fog": "cloud.fog.fill",
            "Showers": "cloud.rain.fill",
            "Mostly cloudy w/ showers": "cloud.sun.rain.fill",
            "Partly sunny w/ showers": "cloud.sun.rain.fill",
            "T-Storms": "cloud.bolt.rain.fill",
            "Mostly cloudy w/ T-Storms": "cloud.sun.bolt.fill",
            "Partly sunny w/ T-Storms": "cloud.sun.bolt.fill",
            "Rain": "cloud.heavyrain.fill",
            "Flurries": "wind.snow",
            "Mostly cloudy w/ flurries": "wind.snow",
            "Partly sunny w/ flurries": "snowflake",
            "Mostly cloudy w/ snow": "cloud.snow.fill",
            "Ice": "cloud.hail.fill",
            "Sleet": "cloud.sleet.fill",
            "Freezing Rain": "cloud.hail.fill",
            "Rain and Snow": "cloud.sleet.fill",
            "Clear": "moon.stars.fill",
            "Mostly clear": "cloud.moon.fill",
            "Partly cloudy": "cloud.moon.fill",
            //"Intermittent Clouds": "cloud.moon.fill",
            "Hazy Moonlight": "smoke.fill"
    ]
    }
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
