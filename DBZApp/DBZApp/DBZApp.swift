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
    
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                HomeView(
                    viewModel: HomeViewModel(
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
                        sortCharactersUseCase: SortCharactersUseCaseImpl()
                    )
                )
            }
        }
    }
}
