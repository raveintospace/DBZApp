//
//  SearchBarView.swift
//  DBZApp
//
//  Created by Uri on 6/9/24.
//

import SwiftUI

struct SearchBar: View {
    
    // Binding instead of State so searchText can bind to any string in our app
    // Where we put a SearchBar, we will bind a string to it
    @Binding var searchText: String
    
    var placeholderText: String = "Search on database"
    var characterLimit: Int = 28
    var onSubmit: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .light : .dbzBlue
                )
            
            TextField(placeholderText, text: $searchText)
                .font(.system(size: 16))
                .foregroundStyle(.dbzBlue)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .onSubmit {
                    onSubmit?()
                }
                .onChange(of: searchText) { _, newValue in
                    if newValue.count > characterLimit {
                        searchText = String(newValue.prefix(characterLimit))
                    }
                }
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)  // easier for users to tap
                        .foregroundStyle(.dbzBlue)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .background(.clear) // easier for users to tap
                        .asButton(.opacity) {
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
                .fill(Color.background.opacity(0.3))
        )
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}

