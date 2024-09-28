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
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            homeWallpaper
            
            VStack(spacing: 0) {
                fullHeader
                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 0) {
                            if viewModel.showNoResultsView {
                                noCharactersView
                            } else {
                                if !viewModel.showFavorites {
                                    displayedCardsSection
                                        .transition(.move(edge: .leading))
                                }
                                if viewModel.showFavorites {
                                    if viewModel.favoriteCharacters.isEmpty {
                                        noFavoritesView
                                            .transition(.move(edge: .trailing))
                                    } else {
                                        displayedCardsSection
                                            .transition(.move(edge: .trailing))
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .clipped()
                    .onChange(of: viewModel.showFavorites) { _, _ in
                        proxy.scrollTo(0, anchor: .top)
                    }
                }
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
            databaseTitleHeader
            searchBar
            filterBar
            sortMenuBar
        }
        .padding()
    }
    
    private var databaseTitleHeader: some View {
        TitleHeader(
            isStarFilled: viewModel.showFavorites,
            onHomeButtonPressed: {
                // go to main view
            }, onFavButtonPressed: {
                withAnimation {
                    viewModel.showFavorites.toggle()
                }
            })
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
    
    private var noCharactersView: some View {
        NoResultsView(
            imageName: "person.slash",
            mainText: "No characters",
            subText: "There are no characters that match your search. Try with other filters or keywords."
        )
    }
    
    private var noFavoritesView: some View {
        NoResultsView(
            imageName: "star.slash",
            mainText: "No favorites",
            subText: "No characters have been marked as favorites yet. Tap the ⭐️ button on any character's card to add it to your favorites."
        )
    }
    
    // cards expand if unpair
    private var displayedCardsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, items: viewModel.displayedCharacters) { character in
            if let character {
                DatabaseCardView(
                    imageName: character.image,
                    name: character.name,
                    ki: character.kiToDisplay,
                    affiliation: character.affiliation,
                    race: character.race,
                    gender: character.genderToDisplay,
                    isFavorite: viewModel.isFavorited(character: character),
                    onCardPressed: {
                        goToDetailView(character: character)
                    },
                    onFavButtonPressed: {
                        withAnimation {
                            viewModel.updateFavorites(character: character)
                        }
                    }
                )
            }
        }
    }
    
    private func goToDetailView(character: Character) {
        router.showScreen(.push) { _ in
            DetailView(character: character)
        }
    }
}
