//
//  SearchView.swift
//  weather
//
//  Created by Nathan on 7/13/21.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var text: String;
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                TextField("Search ...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)

                
            }.navigationTitle("Search Cities")
                
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant(""))
    }
}
