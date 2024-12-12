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
    
    
    @Published var rivalPoints: Decimal = 0
    @Published var playerPoints: Decimal = 0
    
    @Published var rivalGames: Int = 0
    @Published var playerGames: Int = 0
    
    @Published var rivalSets: Int = 0
    @Published var playerSets: Int = 0
    
    @Published var gamesToWin: Int = 2  // update
    @Published var setsToWin: Int = 2   // update
    
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
        gameTextMessage = .empty
        shouldShuffleCards = true
        hasGameStarted = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dealCards()
            self.updatePoints()
        }
    }
    
    func endGame() {
        rivalPoints = 0
        playerPoints = 0
        rivalGames = 0
        playerGames = 0
        rivalSets = 0
        playerSets = 0
        
        shouldRevealRivalCards = false
        shouldRevealPlayerCards = false
        gameTextMessage = .empty
        
        rivalCards.removeAll()
        playerCards.removeAll()
        cardsToDiscard.removeAll()
        
        hasGameStarted = false
        hasGameFinished = false
    }
    
    func compareCards() {
        shouldRevealRivalCards = true
        discardsUsed = 0
        deselectSelectedCards()
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
        guard gameCharacters.count >= 6 else {
            debugPrint("Not enough cards to deal")
            return
        }
        
        gameCharacters.shuffle()
        
        // Deal cards to rival - pending animation
        rivalCards = Array(gameCharacters.prefix(3))
        gameCharacters.removeFirst(3)
        
        // Deal cards to player - pending animation
        playerCards = Array(gameCharacters.prefix(3))
        gameCharacters.removeFirst(3)
        
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
    
    func toggleCardSelection(_ card: GameCharacter) {        
        if let index = playerCards.firstIndex(where: { $0.id == card.id }) {
            playerCards[index].isSelected.toggle()
            if playerCards[index].isSelected {
                cardsToDiscard.append(playerCards[index])
                debugPrint("Card added to discarded")
            } else {
                cardsToDiscard.removeAll { $0.id == card.id }
                debugPrint("Card removed from discarded")
            }
        }
    }
    
    func discardCardsAndDealNewOnes() {
        guard discardsUsed < discardsAllowed else { return }
        
        discardsUsed += 1
        var newCardsToDeal = [GameCharacter]() // Array of new cards to deal
        var discardedIndices = [Int]()        // Array of discarted cards' indices
        
        // Identify discarted card's indices
        for (index, card) in playerCards.enumerated() {
            if cardsToDiscard.contains(where: { $0.id == card.id }) {
                discardedIndices.append(index)
            }
        }
        
        // Remove discarted cards from player
        playerCards.removeAll { card in
            cardsToDiscard.contains { $0.id == card.id }
        }
        
        // Reset isSelected and return discarted cards to deck
        for var card in cardsToDiscard {
            card.isSelected = false
            gameCharacters.append(card)
        }
        cardsToDiscard.removeAll()
        
        // Animate shuffle cards
        shouldShuffleCards = true
        gameCharacters.shuffle()
        
        // Deal new cards to empty indices
        for index in discardedIndices {
            if let newCard = gameCharacters.first {
                newCardsToDeal.append(newCard)
                playerCards.insert(newCard, at: index)
                gameCharacters.removeFirst()
            }
        }
        
        shouldRevealPlayerCards = true
        updatePoints()
    }
    
    private func deselectSelectedCards() {
        for card in cardsToDiscard {
            if let index = playerCards.firstIndex(where: { $0.id == card.id }) {
                playerCards[index].isSelected = false
            }
        }
        cardsToDiscard.removeAll()
    }
    
    private func updateScoreboard() {
        playerPoints == rivalPoints ? handleDraw() : (playerPoints > rivalPoints ? addVictoryToPlayer() : addVictoryToRival())
    }
    
    private func handleDraw() {
        debugPrint("Draw")
        gameTextMessage = .draw
    }
    
    private func addVictoryToPlayer() {
        playerGames += 1
        gameTextMessage = .gameWon
            
        if playerGames == gamesToWin {
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
        rivalGames += 1
        gameTextMessage = .gameLost
        
        if rivalGames == gamesToWin {
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
        gameTextMessage = .matchWon
        // play sound
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hasGameFinished = true
        }
    }
    
    private func rivalHasWon() {
        gameTextMessage = .matchLost
        // play sound
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hasGameFinished = true
        }
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
    
    func areDiscardsAllowed() -> Bool {
        return discardsUsed < discardsAllowed
    }
}

// MARK: - To Do
/*

 */
