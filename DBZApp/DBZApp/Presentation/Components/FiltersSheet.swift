//
//  FiltersSheet.swift
//  DBZApp
//
//  Created by Uri on 12/9/24.
//

import SwiftUI

struct FiltersSheet: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var filterOptions: [FilterOption] = FilterOption.allCases
    @Binding var selection: FilterOption
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
                ForEach(filterOptions, id: \.self) { filterOption in
                    filterOption.displayName()
                        .font(.system(size: 50))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            ZStack {
                                Capsule(style: .circular)
                                    .fill(.dbzYellow)
                                    .opacity(selection == filterOption ? 1 : 0)
                                
                                Capsule(style: .circular)
                                    .stroke(lineWidth: 2)
                            }
                        )
                        .sensoryFeedback(.impact, trigger: trigger)
                        .foregroundStyle(.dbzBlue)
                        .onTapGesture {
                            selection = filterOption
                            trigger = true
                            // viewModel.selectedFilterOption = filterOption
                        }
                }
            }
        }
    }
}

#Preview {
    FiltersSheet(viewModel: DeveloperPreview.instance.homeViewModel, selection: .constant(.affiliation))
}
