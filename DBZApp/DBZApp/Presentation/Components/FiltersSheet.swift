//
//  FiltersSheet.swift
//  DBZApp
//
//  Created by Uri on 12/9/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct FiltersSheet: View {
    
    @Environment(\.router) var router
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: HomeViewModel
    
    var filterOptions: [FilterOption] = FilterOption.allCases
    @Binding var selection: FilterOption
   
    @State private var trigger = false
    var triggerDelay: Double = 0.3
    
    var body: some View {
        ZStack {
            Image("namekWallpaper")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.12)
            
            HStack {
                ImageOrangeCircleButton(imageName: "xmark")
                    .asButton(.press) {
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
                        .asButton(.press) {
                            selection = filterOption
                            trigger = true
                            viewModel.selectedFilterOption = filterOption
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                                trigger = false
                            }
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
        FiltersSheet(viewModel: DeveloperPreview.instance.homeViewModel, selection: .constant(.affiliation))
    }
}
