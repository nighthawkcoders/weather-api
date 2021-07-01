//
//  WeatherButton.swift
//  weather
//
//  Created by Michael Hayes on 6/29/21.
//

import SwiftUI

struct WeatherButton: View {
    var text: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(text)
            .frame(width: 280, height: 50, alignment: .center)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10.0)
    }
}
