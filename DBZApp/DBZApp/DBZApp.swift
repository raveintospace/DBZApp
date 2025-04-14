//
//  DBZAppApp.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI
import SwiftfulRouting
import GoogleMobileAds
import AppTrackingTransparency

@main
struct DBZApp: App {
    
    @StateObject private var vm = DatabaseViewModel(
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
    
    @State private var showSplashView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RouterView { _ in
                    LandingView()
                }
                .environmentObject(vm) // -> Available for the whole app
                
                SplashView(showSplashView: $showSplashView)
                    .opacity(showSplashView ? 1.0 : 0.0)
            }
        }
    }
}
