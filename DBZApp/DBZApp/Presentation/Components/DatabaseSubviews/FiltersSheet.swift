//
//  FiltersSheet.swift
//  DBZApp
//
//  Created by Uri on 12/9/24.
//

import SwiftUI
import SwiftfulRouting

struct FiltersSheet: View {
    
    @Environment(\.router) private var router
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: DatabaseViewModel
    
    var filterOptions: [FilterOption] = FilterOption.allCases
    @Binding var selection: FilterOption
   
    @State private var trigger = false
    
    var body: some View {
        ZStack {
            Image("filtersWallpaper")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.12)
            
            HStack {
                ImageOrangeCircle(imageName: "xmark")
                    .sensoryFeedback(.impact, trigger: trigger)
                    .withTrigger(trigger: $trigger) {
                        router.dismissScreen()
                    }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            VStack(alignment: .center, spacing: 30) {
                Text("Select how to filter the Dragon Ball characters")
                    .bold()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    
                
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
                        .withTrigger(trigger: $trigger) {
                            selection = filterOption
                            viewModel.selectedFilterOption = filterOption
                        }
                }
            }
            .foregroundStyle(.dbzBlue)
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    RouterView { _ in
        FiltersSheet(viewModel: DeveloperPreview.instance.databaseViewModel, selection: .constant(.affiliation))
    }
}
