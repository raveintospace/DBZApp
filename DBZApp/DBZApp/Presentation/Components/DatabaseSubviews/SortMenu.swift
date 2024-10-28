//
//  SortMenu.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import SwiftUI

struct SortMenu: View {
    
    @ObservedObject var viewModel: DatabaseViewModel
    
    var body: some View {
        HStack {
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
            .tint(.dbzBlue)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    SortMenu(viewModel: DeveloperPreview.instance.databaseViewModel)
        .padding()
}

extension SortMenu {
    private func menuTitleView(sortOption: SortOption) -> some View {
        sortOption.displayName()
    }
}

