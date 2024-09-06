//
//  HomeView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        // Filters
                        // Sort
                        // cards
                        ForEach(viewModel.isSearching ? viewModel.filteredCharacters : viewModel.characters) { character in
                            VStack(alignment: .leading) {
                                Text(character.name)
                                Text(character.race)
                                Text(character.affiliation)
                            }
                            .foregroundStyle(.accent)
                        }
                    } header: {
                        SearchBarView(searchText: $viewModel.searchText)
                            .background(.own)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await viewModel.loadLocalCharacters()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    HomeView(viewModel: DeveloperPreview.instance.homeViewModel)
}
