//
//  HomeView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct HomeView: View {
    
    @Environment(\.router) var router
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            homeWallpaper
            
            VStack(spacing: 0) {
                fullHeader
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        // cards
                        if viewModel.showNoResultsView {
                            NoResultsView()
                        } else {
                            databaseCardsSection
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .clipped()
            }
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
    
    private var homeWallpaper: some View {
        Image("kamaWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var fullHeader: some View {
        VStack {
            TitleHeader()
            searchBar
            filterBar
            sortMenuBar
        }
        .padding()
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
        .padding(.leading, -10)
    }
    
    private var sortMenuBar: some View {
        SortMenu(viewModel: viewModel)
    }
    
    private var databaseCardsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, items: viewModel.displayedCharacters) { character in
            if let character {
                DatabaseCardView(
                    imageName: character.image,
                    name: character.name,
                    ki: character.kiToDisplay,
                    affiliation: character.affiliation,
                    race: character.race,
                    gender: character.genderToDisplay,
                    isFavorite: false,
                    onCardPressed: {
                        // go to detail view
                    },
                    onFavButtonPressed: {
                        // viewmodel favorite
                    }
                )
            }
        }
    }
    
    private var dummyVstack: some View {
        ForEach(viewModel.displayedCharacters) { character in
            LazyVStack(alignment: .center) {
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
}
