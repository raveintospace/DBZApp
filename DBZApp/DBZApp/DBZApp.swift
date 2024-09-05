//
//  DBZAppApp.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

@main
struct DBZApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(getLocalCharactersUseCase: GetLocalCharactersUseCase(repository: CharacterRepositoryImpl(localDataSource: LocalCharacterDataSource(), networkDataSource: NetworkCharacterDataSource())), fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCase(repository: CharacterRepositoryImpl(localDataSource: LocalCharacterDataSource(), networkDataSource: NetworkCharacterDataSource()))))
        }
    }
}
