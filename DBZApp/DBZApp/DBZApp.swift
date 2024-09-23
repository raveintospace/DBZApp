//
//  DBZAppApp.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI
import SwiftfulRouting

@main
struct DBZApp: App {
    
    @StateObject private var vm = HomeViewModel(
        getLocalCharactersUseCase: GetLocalCharactersUseCaseImpl(
            repository: CharacterRepositoryImpl(
                localDataSource: LocalCharacterDataSource(),
                networkDataSource: NetworkCharacterDataSource()
            )
        ),
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseImpl(
            repository: CharacterRepositoryImpl(
                localDataSource: LocalCharacterDataSource(),
                networkDataSource: NetworkCharacterDataSource()
            )
        ),
        getFiltersUseCase: GetFiltersUseCaseImpl(repository: FilterRepositoryImpl()),
        sortCharactersUseCase: SortCharactersUseCaseImpl(),
        favoritesUseCase: FavoritesUseCaseImpl(
            repository: FavoritesRepositoryImpl(
                dataSource: FavoritesDataSource()
            )
        )
    )
    
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                HomeView(viewModel: vm)
            }
            .environmentObject(vm) // -> Available for the whole app
        }
    }
}
