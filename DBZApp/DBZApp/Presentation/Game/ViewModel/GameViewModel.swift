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
    
    @Published var rivalPoints: Decimal = 0
    @Published var playerPoints: Decimal = 0
    
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
        updatePoints()
    }
    
    func testDealAndUpdate() {
        dealCards()
        updatePoints()
        debugPrint("Rival points: \(KiFormatter.formatDecimalToString(rivalPoints))")
        debugPrint("Player points: \(KiFormatter.formatDecimalToString(playerPoints))")
        updateScoreboard()
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
        guard gameCharacters.count >= 6 else {
            debugPrint("Not enough cards to deal")
            return
        }
        
        // Shuffle cards
        var shuffledCharacters = gameCharacters.shuffled()
        
        // Deal cards to rival
        rivalCards = Array(shuffledCharacters.prefix(3))
        shuffledCharacters.removeFirst(3)
        
        // Deal cards to player
        playerCards = Array(shuffledCharacters.prefix(3))
        shuffledCharacters.removeFirst(3)
        
        // Update gameCharacters with shuffledCharacters left
        gameCharacters = shuffledCharacters
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
        debugPrint("Player has won")
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
        debugPrint("Rival has won")
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
    
    private func calculateTotalPoints(for characters: [GameCharacter]) -> Decimal {
        var totalPoints: Decimal = 0
        var hasJoker = false
        var hasMalus = false
        
        for character in characters {
            let kiLowercased = character.kiToCompare.lowercased()
            
            if kiLowercased == "unknown" {
                hasJoker = true
            } else if kiLowercased.contains("googolplex") {
                hasMalus = true
            } else if let kiValue = KiFormatter.convertKiPointsToDecimal(character.kiToCompare) {
                totalPoints += kiValue
            }
        }
        
        if hasJoker {
            totalPoints *= 1.5
        }
        
        if hasMalus {
            debugPrint("**Malus appeared**")
            totalPoints /= 2
        }
        
        return totalPoints
    }
    
    private func updatePoints() {
        rivalPoints = calculateTotalPoints(for: rivalCards)
        playerPoints = calculateTotalPoints(for: playerCards)
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
