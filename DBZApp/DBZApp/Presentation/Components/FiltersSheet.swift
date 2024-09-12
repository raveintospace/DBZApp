//
//  FiltersSheet.swift
//  DBZApp
//
//  Created by Uri on 12/9/24.
//

import SwiftUI

struct FiltersSheet: View {
    
    var filtersText: [String] = ["Affiliation", "Gender", "Race"]
    @Binding var selection: String
    @State private var trigger = false
    
    var body: some View {
        ZStack {
            HStack {
                Circle()
                    .fill(.dbzOrange)
                    .overlay(
                        Image(systemName: "xmark")
                            .offset(y: 1)
                    )
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.dbzBlue)
                    .font(.title2)
                    .fontWeight(.bold)
                    .onTapGesture {
                        // dismiss screen
                    }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            VStack(alignment: .center, spacing: 30) {
                ForEach(filtersText, id: \.self) { filterText in
                    Text(filterText)
                        .font(.system(size: 50))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            ZStack {
                                Capsule(style: .circular)
                                    .fill(.dbzYellow)
                                    .opacity(selection == filterText ? 1 : 0)
                                
                                Capsule(style: .circular)
                                    .stroke(lineWidth: 2)
                            }
                        )
                        .sensoryFeedback(.impact, trigger: trigger)
                        .foregroundStyle(.dbzBlue)
                        .onTapGesture {
                            selection = filterText
                            trigger = true
                            // activate method in viewmodel to load filter in homeview
                        }
                }
            }
        }
    }
}

#Preview {
    FiltersSheetPreview()
}

fileprivate struct FiltersSheetPreview: View {
    var filtersText: [String] = ["Affiliation", "Gender", "Race"]
    @State private var selection = ""
    
    var body: some View {
        FiltersSheet(filtersText: filtersText, selection: $selection)
    }
}
