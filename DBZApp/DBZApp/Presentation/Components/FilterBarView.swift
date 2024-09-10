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
                            .padding(.leading, 16)
                    }
                    
                    ForEach(filters, id: \.self) { filter in
                        if selectedFilter == nil || selectedFilter == filter {
                            FilterCell(
                                title: filter.title,
                                isSelected: selectedFilter == filter
                            )
                            .onTapGesture {
                                onFilterPressed?(filter)
                            }
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .scrollIndicators(.hidden)
            .animation(.bouncy, value: selectedFilter)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .foregroundStyle(.dbzBlue)
                .onTapGesture {
                    onOptionButtonPressed?()
                }
        }
    }
}

#Preview {
    FilterBarViewPreview()
}

// Preview to check if filter logic works
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

