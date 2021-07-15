//
//  SearchView.swift
//  weather
//
//  Created by Nathan on 7/13/21.
//

import SwiftUI

struct SearchView: View {
    
    @State var text: String;
    @State var cities: Array<String> = ["San Diego", "Los Angeles", "New York"];
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                TextField("Search ...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)

                    Text("Text: \(text)")
                
                List {
                    
                    ForEach((0...cities.count-1), id: \.self) { i in
                        if cities[i].range(of:text, options: .caseInsensitive) != nil {
                            Text(cities[i])
                        }
                    }
                    
                }
                
            }.navigationTitle("Search Cities")
                
        }
    }
}

struct Cities: Codable, Identifiable {
    let id = UUID()
    var DateTime: String
    var EpochDateTime: Int
    var WeatherIcon: Int
    var IconPhrase: String
    var HasPrecipitation: Bool
    var IsDaylight: Bool
    var PrecipitationProbability: Int
    var MobileLink: String
    var Link: String
    
}

class API: ObservableObject {
    @Published var cities = [Cities]()
    
    func loadData(completion:@escaping ([Cities]) -> ()) {
        guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/topcities/50?apikey=zTo2UcAjr8v33iTfrHinyQnBYh7u8253") else {
            // San Diego: 38497_PC
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let hours = try! JSONDecoder().decode([Cities].self, from: data!)
            
            //            print(hours)
//            var converter = ConvertDate(time: 1625083200)
//            print(converter.hour)
//            DispatchQueue.main.async {
//                completion(hours)
//            }
        }.resume()
    }
}

// http://dataservice.accuweather.com/locations/v1/topcities/50?apikey=zTo2UcAjr8v33iTfrHinyQnBYh7u8253

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text:"")
    }
}
