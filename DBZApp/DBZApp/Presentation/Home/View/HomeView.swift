//
//  HomeView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    @State private var selectedFilter: Filter? = nil
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        // Sort
                        // cards
                        ForEach(viewModel.isSearching ? viewModel.filteredCharacters : viewModel.characters) { character in
                            VStack(alignment: .center) {
                                Text(character.name)
                                Text(character.race)
                                Text(character.affiliation)
                                Text(character.gender)
                                Divider()
                            }
                            .foregroundStyle(.accent)
                        }
                    } header: {
                        fullHeader
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

extension HomeView {
    
    private var fullHeader: some View {
        VStack(spacing: 4) {
            searchBar
            filterBar
        }
        .background(.own)
        .padding(8)
    }
    
    private var searchBar: some View {
        SearchBarView(searchText: $viewModel.searchText)
    }
    
    private var filterBar: some View {
        FiltersBarView(
            filters: viewModel.affiliationFilters,
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
