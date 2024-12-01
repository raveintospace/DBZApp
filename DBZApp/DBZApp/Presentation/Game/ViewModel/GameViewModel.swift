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
    @Published var rivalCards: [GameCharacter] = []
    @Published var playerCards: [GameCharacter] = []
    @Published var cardsToDiscard: [GameCharacter] = []
    
    @Published var hasGameStarted: Bool = false
    @Published var hasGameFinished: Bool = false
    @Published var shouldShuffleCards: Bool = false
    @Published var shouldRevealPlayerCards: Bool = false
    @Published var shouldRevealRivalCards: Bool = false
    @Published var showResetGameAlert: Bool = false
    @Published var showPlayAgainAlert: Bool = false
    
    @Published var rivalPoints: Int = 0
    @Published var playerPoints: Int = 0
    
    @Published var rivalGames: Int = 0
    @Published var playerGames: Int = 0
    
    @Published var rivalSets: Int = 0
    @Published var playerSets: Int = 0
    
    @Published var gamesToWin: Int = 3
    @Published var setsToWin: Int = 3
    
    @Published var discardsUsed: Int = 0
    
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
    
    func startGame() {
        // remove welcome message - set to empty
        shouldShuffleCards = true
        dealCards()
    }
    
    func endGame() {
        
    }
    
    func resetGame() {
        rivalPoints = 0 // rivalCards.kitocompare.count
        playerPoints = 0 // playerCards.kitocompare.count
        rivalGames = 0
        playerGames = 0
        rivalSets = 0
        playerSets = 0
        
        rivalCards.removeAll()
        playerCards.removeAll()
        cardsToDiscard.removeAll()
    }
    
    func revealPlayerCards() {
        shouldRevealRivalCards = true
        discardsUsed = 0
        // updateScoreboard
        // update message
    }
    
    func playNextRound() {
        // send cards back to deck
        rivalCards.removeAll()
        playerCards.removeAll()
        shouldShuffleCards = true
        shouldRevealRivalCards = false
        shouldRevealPlayerCards = false
        dealCards()
    }
    
    private func dealCards() {
        // deal cards to rival: append to array + animation
        // deal cards to player: append to array + animation
        shouldRevealPlayerCards = true
    }
    
    func dealCardsAfterDiscard() {
        discardsUsed += 1
        // send discarted cards back to deck
        // remove discarted cards from cardsToDiscard & playerCards
        // deal new cards to player
        // reveal new cards
    }
    
    private func updateScoreboard() {
        playerPoints > rivalPoints ? addVictoryToPlayer() : addVictoryToRival()
    }
    
    private func addVictoryToPlayer() {
        if playerSets < setsToWin {
            if playerGames < gamesToWin {
                playerGames += 1
            } else {
                playerSets += 1
            }
        } else {
            // player has won the match
        }
    }
    
    private func addVictoryToRival() {
        if rivalSets < setsToWin {
            if rivalGames < gamesToWin {
                rivalGames += 1
            } else {
                rivalSets += 1
            }
        } else {
            // rival has won the match
        }
    }
    
    private func playerHasWon() {
        // update message
        // play sound
        hasGameFinished = true
        // show play again alert
    }
    
    private func rivalHasWon() {
        // update message
        // play sound
        hasGameFinished = true
        // show play again alert
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
