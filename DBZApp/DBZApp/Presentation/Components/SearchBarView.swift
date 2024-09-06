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
    
    var placeholderText: String = "Search on database"
    
    var characterLimit: Int = 28
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .light : .accent
                )
            
            TextField(placeholderText, text: $searchText)
                .font(.system(size: 16))
                .foregroundStyle(.accent)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .onChange(of: searchText) { _, newValue in
                    if newValue.count > characterLimit {
                        searchText = String(newValue.prefix(characterLimit))
                    }
                }
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)  // easier for users to tap
                        .foregroundStyle(.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
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
                .shadow(color: .accent.opacity(0.25),
                        radius: 10, x: 0, y:0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

