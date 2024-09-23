//
//  DeveloperPreview.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

@MainActor
final class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let localDataSource = LocalCharacterDataSource()
    let networkDataSource = NetworkCharacterDataSource()
    
    let characterRepository = CharacterRepositoryImpl(
        localDataSource: LocalCharacterDataSource(),
        networkDataSource: NetworkCharacterDataSource()
    )
    
    let homeViewModel = HomeViewModel(
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
        
        getFiltersUseCase: GetFiltersUseCaseImpl(
            repository: FilterRepositoryImpl()
        ),
        sortCharactersUseCase: SortCharactersUseCaseImpl(),
        favoritesUseCase: FavoritesUseCaseImpl(
            repository: FavoritesRepositoryImpl(
                dataSource: FavoritesDataSource()
            )
        )
    )
}
