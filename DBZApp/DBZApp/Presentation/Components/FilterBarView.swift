//
//  FilterBarView.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import SwiftUI

struct FilterBarView: View {
    var filters: [Filter] = Filter.dbzFilters
    var onXMarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((Filter) -> Void)? = nil
    
    // The value is passed by the parent view
    var selectedFilter: Filter? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.dbzBlue)
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading).combined(with: .opacity))
                }
                
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        FilterCell(
                            title: filter.title,
                            isSelected: selectedFilter == filter
                        )
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(0)
                    }
                }
            }
            .padding(.vertical, 8) // avoids bottom & top of HStack looking cut
            .padding(.horizontal, 8)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

#Preview {
    FilterBarViewPreview()
}

// preview to check if filter logic works
// the two properties will be in our parent view
fileprivate struct FilterBarViewPreview: View {
    
    @State private var filters = Filter.dbzFilters
    @State private var selectedFilter: Filter? = nil
    
    var body: some View {
        FilterBarView(
            filters: filters,
            onXMarkPressed: {
                selectedFilter = nil
            },
            onFilterPressed: { newFilter in
                selectedFilter = newFilter
            },
            selectedFilter: selectedFilter
        )
    }
}
