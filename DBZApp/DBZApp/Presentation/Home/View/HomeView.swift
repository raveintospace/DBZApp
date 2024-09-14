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
            ScrollView(.vertical) {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        // Sort
                        // cards
                        if viewModel.showNoResultsView {
                            noResultsView
                        } else {
                            ForEach(viewModel.displayedCharacters) { character in
                                VStack(alignment: .center) {
                                    Text(character.name)
                                    Text(character.affiliation)
                                    Text(character.gender)
                                    Text(character.race)
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
        .onChange(of: viewModel.selectedFilterOption, { _, newFilter in
            viewModel.selectedFilterOption = newFilter
        })
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
    
    private var noResultsView: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.slash")
                .font(.system(size: 40))
                .foregroundStyle(.light.opacity(0.3))
            Text("No characters")
                .font(.system(size: 40))
                .bold()
            Text("There are no characters that match your search. Try with other filters or keywords.")
                .font(.callout)
        }
        .foregroundColor(.accent)
        .multilineTextAlignment(.center)
        .padding(50)
    }
}
