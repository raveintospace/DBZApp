//
//  FiltersBarView.swift
//  DBZApp
//
//  Created by Uri on 10/9/24.
//

import SwiftUI

struct FiltersBarView: View {
    var filters: [Filter] = Filter.affiliation
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
                            .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 4 : 0)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .scrollIndicators(.hidden)
            .animation(.bouncy, value: selectedFilter)
            
            Image(systemName: "slider.horizontal.3")
                .foregroundStyle(.dbzBlue)
                .padding(.trailing, 8)
                .padding(.leading, 2)
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
            selectedFilter: selectedFilter
        )
    }
}
