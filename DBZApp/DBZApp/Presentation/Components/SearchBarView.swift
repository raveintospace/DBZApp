//
//  SearchBarView.swift
//  DBZApp
//
//  Created by Uri on 6/9/24.
//

import SwiftUI

struct SearchBarView: View {
    
    // Binding instead of State so searchText can bind to any string in our app
    // Where we put a SearchBarView, we will bind a string to it
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .light : .accent
                )
            
            TextField("Search character", text: $searchText)
                .font(.system(size: 16))
                .foregroundStyle(.accent)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)  // easier for users to tap
                        .foregroundStyle(.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.hideKeyboard()
                            searchText = ""
                        }
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

