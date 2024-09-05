//
//  DeveloperPreview.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

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
        getLocalCharactersUseCase: GetLocalCharactersUseCase(
            repository: CharacterRepositoryImpl(
                localDataSource: LocalCharacterDataSource(),
                networkDataSource: NetworkCharacterDataSource()
            )
        ),
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCase(
            repository: CharacterRepositoryImpl(
                localDataSource: LocalCharacterDataSource(),
                networkDataSource: NetworkCharacterDataSource()
            )
        )
    )
}
