//
//  GameViewModel.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation

@MainActor
final class GameViewModel: ObservableObject {
    
    @Published var gameCharacters: [GameCharacter] = []
    
    private let databaseViewModel: DatabaseViewModel
    
    init(databaseViewModel: DatabaseViewModel) {
        self.databaseViewModel = databaseViewModel
        Task {
            await databaseViewModel.loadLocalCharacters()
            loadGameCharacters()
        }
    }
    
    private func loadGameCharacters() {
        self.gameCharacters = databaseViewModel.allCharacters.map( { character in
            GameCharacterMapper.mapCharacterToGameCharacter(character)
        })
    }
}

// MARK: - To Do
/*
 var hasGameStarted: Bool = false // viewModel.hasGameStarted
 var hasGameFinished: Bool = false // viewModel.hasGameFinished
 var hasSelectedCards: Bool = false // !viewModel.cardsToDiscardArray.isEmpty
 var areRivalCardsShown: Bool = false  // viewModel.areRivalCardsShown
 
 Var to set gameinfotext - viewmodel.gameinfotext - based on enum switch, empty as default
 */
