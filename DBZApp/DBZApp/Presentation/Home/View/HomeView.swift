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
    
    @State private var showFavoritesGrid: Bool = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
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
                        if viewModel.showNoResultsView {
                            noCharactersView
                        } else {
                            if !showFavoritesGrid {
                                databaseAllCardsSection
                                    .transition(.move(edge: .leading))
                            }
                            if showFavoritesGrid {
                                if viewModel.favoriteCharacters.isEmpty {
                                    noFavoritesView
                                        .transition(.move(edge: .trailing))
                                } else {
                                    databaseFavoriteCardsSection
                                        .transition(.move(edge: .trailing))
                                }
                            }
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
            databaseTitleHeader
            searchBar
            filterBar
            sortMenuBar
        }
        .padding()
    }
    
    private var databaseTitleHeader: some View {
        TitleHeader(
            onHomePressed: {
            
        }, onFavPressed: {
            withAnimation {
                showFavoritesGrid.toggle()
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
    
    // cards expand if unpair
    private var databaseAllCardsSection: some View {
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
                        viewModel.updateFavorites(character: character)
                        debugPrint(viewModel.favoriteCharacters.count)
                    }
                )
            }
        }
    }
    
    private var noFavoritesView: some View {
        NoResultsView(
            imageName: "star.slash",
            mainText: "No favorites",
            subText: "There are no characters tagged as favorite. Press the ⭐️ button on the character's card to save it to your favorites."
        )
    }
    
    private var databaseFavoriteCardsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, items: viewModel.favoriteCharacters) { character in
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
                        viewModel.updateFavorites(character: character)
                        debugPrint(viewModel.favoriteCharacters.count)
                    }
                )
            }
        }
    }
}


// MARK: - Deprecated
//// cards have same size
//private var databaseCardsGrid: some View {
//    LazyVGrid(columns: columns) {
//        ForEach(viewModel.displayedCharacters) { character in
//            DatabaseCardView(
//                imageName: character.image,
//                name: character.name,
//                ki: character.kiToDisplay,
//                affiliation: character.affiliation,
//                race: character.race,
//                gender: character.genderToDisplay,
//                isFavorite: false,
//                onCardPressed: {
//                    // go to detail view
//                },
//                onFavButtonPressed: {
//                    // viewmodel favorite
//                }
//            )
//        }
//    }
//}
