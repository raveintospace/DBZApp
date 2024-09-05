//
//  HomeView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    
    var body: some View {
        List(viewModel.characters) { character in
            Text(character.name)
                .foregroundStyle(.accent)
        }
        .task {
            await viewModel.loadLocalCharacters()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(
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
    ))
}
