//
//  SortMenu.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import SwiftUI

struct ScrollAndSortBarView: View {
    
    //@EnvironmentObject private var viewModel: HomeViewModel
    @ObservedObject var viewModel: HomeViewModel
    var showScrollToTopButton: Bool = false
    var onScrollToTopButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    onScrollToTopButtonPressed?()
                }
            }) {
                Image(systemName: "arrow.up.to.line")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .transition(.opacity)
            .animation(.easeInOut, value: showScrollToTopButton)
            
            Menu {
                ForEach(SortOption.allCases, id: \.self) { sortOption in
                    Button(action: {
                        viewModel.sortOption = sortOption
                    }) {
                        sortOption.displayName()
                    }
                }
            } label: {
                menuTitleView(sortOption: viewModel.sortOption)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .tint(.dbzBlue)
    }
}

#Preview {
    ScrollAndSortBarView(viewModel: DeveloperPreview.instance.homeViewModel)
        .padding()
}

extension ScrollAndSortBarView {
    private func menuTitleView(sortOption: SortOption) -> some View {
        sortOption.displayName()
    }
}

