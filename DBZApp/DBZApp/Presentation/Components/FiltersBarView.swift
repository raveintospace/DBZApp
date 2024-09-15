//
//  FiltersBarView.swift
//  DBZApp
//
//  Created by Uri on 10/9/24.
//

import SwiftUI

struct FiltersBarView: View {
    var filters: [Filter] = []
    var onXMarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((Filter) -> Void)? = nil
    var onOptionButtonPressed: (() -> Void)? = nil
    
    // The value is passed by the parent view
    var selectedFilter: Filter? = nil
    
    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    
                    if selectedFilter != nil {
                        Image(systemName: "xmark")
                            .padding(8)
                            .background(
                                Circle()
                                    .stroke(lineWidth: 1))
                            .foregroundStyle(.dbzBlue)
                            .onTapGesture {
                                onXMarkPressed?()
                            }
                            .transition(.move(edge: .leading).combined(with: .opacity))
                            .padding(.leading, 4)
                            .padding(.trailing, 4) // avoids hitting another cell
                    }
                    
                    ForEach(filters, id: \.self) { filter in
                        if selectedFilter == nil || selectedFilter == filter {
                            FilterCell(
                                title: filter.title.capitalized,
                                isSelected: selectedFilter == filter
                            )
                            .onTapGesture {
                                onFilterPressed?(filter)
                            }
                            .transition(.move(edge: .trailing).combined(with: .opacity)) // check
                            .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 4 : 0)
                        }
                    }
                }
                .padding(8)
            }
            .scrollIndicators(.hidden)
            .animation(.bouncy, value: selectedFilter)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(
                    Circle()
                        .stroke(lineWidth: 1))
                .foregroundStyle(.dbzBlue)
                .onTapGesture {
                    onOptionButtonPressed?()
                }
        }
    }
}

#Preview {
    FiltersBarViewPreview()
}

// Preview to check if filter logic works
fileprivate struct FiltersBarViewPreview: View {
    
    @State private var filters = [
        Filter(title: "Army of Frieza"),
        Filter(title: "Assistant of Beerus"),
        Filter(title: "Assistant of Vermoud"),
        Filter(title: "Freelancer"),
        Filter(title: "Namekian Warrior"),
        Filter(title: "Other"),
        Filter(title: "Pride Troopers"),
        Filter(title: "Red Ribbon Army"),
        Filter(title: "Villain"),
        Filter(title: "Z Fighter")
    ]
    @State private var selectedFilter: Filter? = nil
    
    var body: some View {
        FiltersBarView(
            filters: filters,
            onXMarkPressed: {
                selectedFilter = nil
            },
            onFilterPressed: { newFilter in
                selectedFilter = newFilter
            },
            onOptionButtonPressed: {
                
            },
            selectedFilter: selectedFilter
        )
    }
}
