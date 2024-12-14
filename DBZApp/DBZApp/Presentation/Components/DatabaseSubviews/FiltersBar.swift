//
//  FiltersBarView.swift
//  DBZApp
//
//  Created by Uri on 10/9/24.
//

import SwiftUI

struct FiltersBar: View {
    var filters: [Filter] = []
    var onXMarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((Filter) -> Void)? = nil
    var onOptionButtonPressed: (() -> Void)? = nil
    
    // The value is passed by the parent view
    var selectedFilter: Filter? = nil
    
    @State private var trigger: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        
                        if selectedFilter != nil {
                            ImageBlueCircle(imageName: "xmark")
                                .sensoryFeedback(.impact, trigger: trigger)
                                .withTrigger(trigger: $trigger) {
                                    onXMarkPressed?()
                                }
                                .transition(.move(edge: .leading).combined(with: .opacity))
                                .padding(.leading, 4)
                                .padding(.trailing, 4) // avoids hitting another cell
                        }
                        
                        ForEach(filters, id: \.id) { filter in
                            if selectedFilter == nil || selectedFilter == filter {
                                FilterCell(
                                    title: filter.title.capitalized,
                                    isSelected: selectedFilter == filter
                                )
                                .sensoryFeedback(.impact, trigger: trigger)
                                .withTrigger(trigger: $trigger) {
                                    onFilterPressed?(filter)
                                }
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                                .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 4 : 0)
                            }
                        }
                    }
                    .padding(8)
                }
                .onChange(of: filters) { _, _ in
                    if let firstFilter = filters.first {
                        scrollViewProxy.scrollTo(firstFilter.id, anchor: .leading)
                    }
                }
                .scrollIndicators(.hidden)
                .animation(.bouncy, value: selectedFilter)
            }
            
            ImageBlueCircle(imageName: "slider.vertical.3")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
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
        FiltersBar(
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
