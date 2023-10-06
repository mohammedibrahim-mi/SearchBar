//
//  searchbar.swift
//  instadesign
//
//  Created by Mohammed Ibrahim on 06/10/23.
//

import SwiftUI



struct SearchBar: View {
    @Binding var text: String
    @Binding var isClear: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled(true)
                .tint(Color.black)
        }
        .onAppear{
            
            if isClear{
                self.text = ""
            }
            
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}
