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
