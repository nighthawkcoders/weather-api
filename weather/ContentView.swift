//
//  ContentView.swift
//  weather
//
//  Created by Michael Hayes on 6/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    @State var hours = [HourlyWeather]()
    
    var body: some View {
        ZStack {
            Background(isNight: $isNight)
            VStack {
                CityText(cityName: "San Diego, CA")
                MainWeatherInfo(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                                temp: "76")
                ScrollView(.horizontal) {
                    List(hours) { hour in
                        WeatherDay(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temp: "74")
                    }
                    /*HStack(spacing: 15) {
                        WeatherDay(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temp: "74")
                        WeatherDay(dayOfWeek: "WED", imageName: "cloud.bolt.rain.fill", temp: "74")
                        WeatherDay(dayOfWeek: "THURS", imageName: "cloud.sun.bolt.fill", temp: "74")
                        WeatherDay(dayOfWeek: "FRI", imageName: "cloud.sleet.fill", temp: "74")
                        WeatherDay(dayOfWeek: "SAT", imageName: "cloud.drizzle.fill", temp: "74")
                    }*/
                }.frame(width: 310, alignment: .center)
                
                Spacer()
                
                Button {
                    isNight.toggle() // action
                } label: { // styling
                    WeatherButton(text: "Change Time of Day",
                                  textColor: .blue,
                                  backgroundColor: .white)
                }
                Spacer()
            }
        }.onAppear() {
            API().loadData { (hours) in
                self.hours = hours
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDay: View {
    var dayOfWeek: String
    var imageName: String
    var temp: String
    
    var body: some View {
        VStack {
            Text(dayOfWeek).font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName).renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temp)°").font(.system(size: 25, weight: .heavy, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct Background: View {
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .trailing).edgesIgnoringSafeArea(.all)
    }
}

struct CityText: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherInfo: View {
    var imageName: String
    var temp: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName).renderingMode(.original).resizable()
                .aspectRatio(contentMode: .fit
                )
                .frame(width: 180, height: 180)
            Text("\(temp)°")
                .font(.system(size: 70, weight: .medium, design:.default))
                .foregroundColor(.white)
        }.padding(.bottom, 45)
    }
}

struct HourlyWeather: Codable, Identifiable {
    let id = UUID()
    var DateTime: String
    var EpochDateTime: Int
    var WeatherIcon: Int
    var IconPhrase: String
    var HasPrecipitation: Bool
    var IsDaylight: Bool
    var Temperature: Temperature
    var PrecipitationProbability: Int
    var MobileLink: String
    var Link: String
    
}

struct Temperature: Codable { // extra struct to conform to Codable (in essence this struct is a tuple- see 00-003 in JSON)
    var Value: Int
    var Unit: String
    var UnitType: Int
}

class API: ObservableObject {
    @Published var hours = [HourlyWeather]()
    
    func loadData(completion:@escaping ([HourlyWeather]) -> ()) {
        guard let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/38497_PC?apikey=zTo2UcAjr8v33iTfrHinyQnBYh7u8253") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let hours = try! JSONDecoder().decode([HourlyWeather].self, from: data!)
            print(hours)
            var converter = ConvertDate()
            print(converter.hourFormatter)
            DispatchQueue.main.async {
                completion(self.hours)
            }
        }.resume()
    }
}

/* Reference JSON
 {
     "DateTime": "2021-06-30T13:00:00-07:00",
     "EpochDateTime": 1625083200,
     "WeatherIcon": 7,
     "IconPhrase": "Cloudy",
     "HasPrecipitation": false,
     "IsDaylight": true,
     "Temperature": {       // start 00
       "Value": 71,
       "Unit": "F",
       "UnitType": 18       // end 003
     },
     "PrecipitationProbability": 0,
     "MobileLink": "http://www.accuweather.com/en/us/san-diego-ca/92101/hourly-weather-forecast/38497_pc?day=1&hbhhour=13&lang=en-us",
     "Link": "http://www.accuweather.com/en/us/san-diego-ca/92101/hourly-weather-forecast/38497_pc?day=1&hbhhour=13&lang=en-us"
   }
 */

