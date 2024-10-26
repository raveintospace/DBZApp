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
                LandingView()
            }
            .environmentObject(vm) // -> Available for the whole app
        }
    }
    
    init() {
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   - \(name)")
            }
        }
    }
}
