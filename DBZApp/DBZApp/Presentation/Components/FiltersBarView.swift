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
        HStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    
                    if selectedFilter != nil {
                        ImageCircleButton(imageName: "xmark")
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
            
            ImageCircleButton(imageName: "slider.vertical.3")
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
    
    @State private var filters = Filter.race
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
