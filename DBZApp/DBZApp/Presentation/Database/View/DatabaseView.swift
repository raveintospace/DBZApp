//
//  DatabaseView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct DatabaseView: View {
    
    @Environment(\.router) var router
    
    @EnvironmentObject var viewModel: DatabaseViewModel
    
    @State private var selectedCharacter: Character? = nil
    
    @State private var setScrollToZero: Bool = false
    
    var body: some View {
        ZStack {
            homeWallpaper
            
            VStack(spacing: 0) {
                fullHeader
                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            if viewModel.isLoading {
                                ProgressColorBarsView()
                                    .padding(.top, 60)
                            } else if let error = viewModel.error {
                                Text(error.errorDescription)
                                    .foregroundColor(.red)
                                    .padding()
                            } else {
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
                    }
                    .scrollIndicators(.hidden)
                    .onChange(of: viewModel.showFavorites) { _, _ in
                        proxy.scrollTo(0, anchor: .top)
                    }
                    .onChange(of: viewModel.sortOption) { _, _ in
                        withAnimation(.smooth) {
                            proxy.scrollTo(0, anchor: .top)
                        }
                    }
                    .onChange(of: viewModel.selectedFilter) { _, _ in
                        withAnimation(.smooth) {
                            proxy.scrollTo(0, anchor: .top)
                        }
                    }
                    .onChange(of: setScrollToZero) { _, _ in
                        withAnimation(.smooth) {
                            proxy.scrollTo(0, anchor: .top)
                        }
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
        DatabaseView()
    }
    .environmentObject(DeveloperPreview.instance.databaseViewModel)
}

extension DatabaseView {
    
    private var homeWallpaper: some View {
        Image("homeWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var fullHeader: some View {
        VStack {
            databaseTitleHeader
            searchBar
            filterBar
            sortBar
        }
        .padding()
        .padding(.top, -10)
    }
    
    private var databaseTitleHeader: some View {
        TitleHeader(
            isStarFilled: viewModel.showFavorites,
            onHomeButtonPressed: {
                router.dismissScreen()
            }, onFavButtonPressed: {
                withAnimation {
                    viewModel.showFavorites.toggle()
                }
            })
    }
    
    private var searchBar: some View {
        SearchBar(
            searchText: $viewModel.searchText,
            onSubmit: {
                setScrollToZero.toggle()
            }
        )
    }
    
    private var filterBar: some View {
        FiltersBar(
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
    
    private var sortBar: some View {
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
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 4, items: viewModel.displayedCharacters) { character in
            if let character {
                DatabaseCard(
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
                        viewModel.updateFavorites(character: character)
                    }
                )
                .padding(.horizontal, 4)
            }
        }
    }
    
    private func goToDetailView(character: Character) {
        selectedCharacter = character
        router.showScreen(.push) { _ in
            DetailLoadingView(character: $selectedCharacter)
        }
    }
}
