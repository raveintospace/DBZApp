//
//  HomeView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI
import SwiftfulRouting

struct HomeView: View {
    
    @Environment(\.router) var router
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Image("kamaWallpaper")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.15)
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        // Sort
                        // cards
                        if viewModel.showNoResultsView {
                            NoResultsView()
                        } else {
                            ForEach(viewModel.displayedCharacters) { character in
                                VStack(alignment: .center) {
                                    Text("Name: \(character.name)")
                                    Text("Affiliation: \(character.affiliation)")
                                    Text("Gender: \(character.gender)")
                                    Text("Race: \(character.race)")
                                    Text("Ki points: \(character.kiToDisplay)")
                                    Divider()
                                }
                                .foregroundStyle(.accent)
                            }
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
    RouterView { _ in
        HomeView(viewModel: DeveloperPreview.instance.homeViewModel)
    }
}

extension HomeView {
    
    private var fullHeader: some View {
        VStack(spacing: 4) {
            searchBar
            filterBar
            sortMenuBar
        }
        .background(.own)
        .padding(8)
    }
    
    private var searchBar: some View {
        SearchBarView(searchText: $viewModel.searchText)
    }
    
    private var filterBar: some View {
        FiltersBarView(
            filters: viewModel.activeSubfilters,
            onXMarkPressed: {
                viewModel.selectedFilter = nil
            },
            onFilterPressed: { newFilter in
                viewModel.selectedFilter = newFilter
            },
            onOptionButtonPressed: {
                viewModel.selectedFilter = nil
                router.showScreen(.sheet) { _ in
                    FiltersSheet(viewModel: viewModel, selection: $viewModel.selectedFilterOption)
                }
            },
            selectedFilter: viewModel.selectedFilter
        )
    }
    
    private var sortMenuBar: some View {
        SortMenu(viewModel: viewModel)
    }
}
