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
    @Published var setsToWin: Int = 2
    
    @Published var discardsUsed: Int = 0
    let discardsAllowed: Int = 2
    
    @Published var gameTextMessage: GameText = .welcome
    
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
        gameTextMessage = .empty
        shouldShuffleCards = true
        hasGameStarted = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dealCards()
            self.updatePoints()
        }
    }
    
    func testDealAndUpdate() {
        dealCards()
        updatePoints()
        debugPrint("Rival points: \(rivalPointsInView())")
        debugPrint("Player points: \(playerPointsInView())")
    }
    
    func endGame() {
        rivalPoints = 0 // rivalCards.kitocompare.count
        playerPoints = 0 // playerCards.kitocompare.count
        rivalGames = 0
        playerGames = 0
        rivalSets = 0
        playerSets = 0
        
        shouldRevealRivalCards = false
        
        rivalCards.removeAll()
        playerCards.removeAll()
        cardsToDiscard.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            debugPrint("endgame activated")
            self.hasGameStarted = false
            self.hasGameFinished = false
            self.shouldRevealPlayerCards = false
            self.gameTextMessage = .empty
        }
    }
    
    func compareCards() {
        shouldRevealRivalCards = true
        discardsUsed = 0
        updateScoreboard()
    }
    
    func playNextRound() {
        gameTextMessage = .empty
        returnCardsToDeck()
        shouldShuffleCards = true
        shouldRevealRivalCards = false
        shouldRevealPlayerCards = false
        dealCards()
        updatePoints()
    }
    
    private func dealCards() {
        // deal cards to player: append to array + animation
        guard gameCharacters.count >= 6 else {
            debugPrint("Not enough cards to deal")
            return
        }
        
        // Shuffle cards
        var shuffledCharacters = gameCharacters.shuffled()
        
        // Deal cards to rival - pending animation
        rivalCards = Array(shuffledCharacters.prefix(3))
        shuffledCharacters.removeFirst(3)
        
        // Deal cards to player - pending animation
        playerCards = Array(shuffledCharacters.prefix(3))
        shuffledCharacters.removeFirst(3)
        
        // Update gameCharacters with shuffledCharacters left
        gameCharacters = shuffledCharacters
        shouldRevealPlayerCards = true
    }
    
    private func returnCardsToDeck() {
        shouldRevealPlayerCards = false
        
        // animate return player cards to deck
        gameCharacters.append(contentsOf: playerCards)
        playerCards.removeAll()
        
        shouldRevealRivalCards = false
        // animate return rival cards to deck
        gameCharacters.append(contentsOf: rivalCards)
        rivalCards.removeAll()
        
        shouldShuffleCards = true
    }
    
    func dealCardsAfterDiscard() {
        // check if discard is allowed
        discardsUsed += 1
        // send discarted cards back to deck
        // remove discarted cards from cardsToDiscard & playerCards
        // deal new cards to player
        // reveal new cards
    }
    
    private func updateScoreboard() {
        playerPoints == rivalPoints ? handleDraw() : (playerPoints > rivalPoints ? addVictoryToPlayer() : addVictoryToRival())
    }
    
    private func handleDraw() {
        debugPrint("Draw")
        gameTextMessage = .draw
    }
    
    private func addVictoryToPlayer() {
        debugPrint("Player has won a game")
        playerGames += 1
        gameTextMessage = .gameWon
            
        if playerGames == gamesToWin {
            debugPrint("Player has won a set")
            playerGames = 0
            rivalGames = 0
            playerSets += 1
            gameTextMessage = .setWon
            
            if playerSets == setsToWin {
                playerHasWon()
            }
        }
    }
    
    private func addVictoryToRival() {
        debugPrint("Rival has won")
        rivalGames += 1
        gameTextMessage = .gameLost
        
        if rivalGames == gamesToWin {
            debugPrint("Rival has won a set")
            playerGames = 0
            rivalGames = 0
            rivalSets += 1
            gameTextMessage = .setLost
            
            if rivalSets == setsToWin {
                rivalHasWon()
            }
        }
    }
    
    private func playerHasWon() {
        // update message
        gameTextMessage = .matchWon
        // play sound
        hasGameFinished = true
        // show play again alert -> endGame
        debugPrint("Player wins the match")
    }
    
    private func rivalHasWon() {
        // update message
        gameTextMessage = .matchLost
        // play sound
        hasGameFinished = true
        // show play again alert -> endGame
        debugPrint("Rival wins the match")
    }
    
    private func calculateTotalPoints(for characters: [GameCharacter]) -> Decimal {
        var totalPoints: Decimal = 0
        var jokerCount = 0
        var hasMalus = false
        
        for character in characters {
            let kiLowercased = character.kiToCompare.lowercased()
            
            if kiLowercased == "unknown" {
                jokerCount += 1
            } else if kiLowercased.contains("googolplex") {
                hasMalus = true
            } else if let kiValue = KiFormatter.convertKiPointsToDecimal(character.kiToCompare) {
                totalPoints += kiValue
            }
        }
        
        if totalPoints == 0 && jokerCount > 0 {
            totalPoints = 0
        }
        
        if jokerCount > 0 && totalPoints > 0 {
            let multiplier = pow(1.5, jokerCount)
            totalPoints *= Decimal(string: "\(multiplier)") ?? 1
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
        debugPrint("Rival Points: \(rivalPoints), Player Points: \(playerPoints)")
    }
    
    func rivalPointsInView() -> String {
        return KiFormatter.formatDecimalToString(rivalPoints)
    }
    
    func playerPointsInView() -> String {
        return KiFormatter.formatDecimalToString(playerPoints)
    }
}

// MARK: - To Do
/*
 var hasGameStarted: Bool = false // viewModel.hasGameStarted
 var hasGameFinished: Bool = false // viewModel.hasGameFinished
 var hasSelectedCards: Bool = false // !viewModel.cardsToDiscardArray.isEmpty
 var areRivalCardsShown: Bool = false  // viewModel.areRivalCardsShown
 */
