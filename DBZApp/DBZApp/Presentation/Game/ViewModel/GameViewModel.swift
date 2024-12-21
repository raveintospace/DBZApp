//
//  GameViewModel.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation
import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {
    
    @Published var gameCharacters: [GameCharacter] = []
    @Published var rivalCards: [GameCharacter] = []
    @Published var playerCards: [GameCharacter] = []
    @Published var cardsToDiscard: [GameCharacter] = []
    
    @Published var hasMatchStarted: Bool = false
    @Published var hasMatchFinished: Bool = false
    @Published var shouldShuffleCards: Bool = false
    @Published var shouldRevealPlayerCards: Bool = false
    @Published var shouldRevealRivalCards: Bool = false
    @Published var showPlayAgainAlert: Bool = false
    
    // MARK: - Scoreboard
    @Published var rivalPoints: Decimal = 0
    @Published var playerPoints: Decimal = 0
    
    @Published var rivalGames: Int = 0
    @Published var playerGames: Int = 0
    
    @Published var rivalSets: Int = 0
    @Published var playerSets: Int = 0
    
    @Published var discardsUsed: Int = 0
    let discardsAllowed: Int = 2
    
    @Published var gameTextMessage: GameText = .welcome
    
    // MARK: - Deal Animation properties
    @Published var rivalCardPositions: [CGRect] = []
    @Published var playerCardPositions: [CGRect] = []
    @Published var deckPosition: CGRect = .zero
    
    private let databaseViewModel: DatabaseViewModel
    
    init(databaseViewModel: DatabaseViewModel) {
        self.databaseViewModel = databaseViewModel
        Task {
            await databaseViewModel.loadLocalCharacters()
            loadGameCharacters()
        }
        loadGameSettings()
    }
    
    private func loadGameCharacters() {
        self.gameCharacters = databaseViewModel.allCharacters.map( { character in
            GameCharacterMapper.mapCharacterToGameCharacter(character)
        })
    }
    
    // MARK: - Intents
    func startMatch() {
        gameTextMessage = .empty
        shouldShuffleCards = true
        hasMatchStarted = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dealCards()
        }
    }
    
    func endMatch() {
        resetScoreboard()
        
        shouldRevealRivalCards = false
        unRevealAllPlayerCards()
        gameTextMessage = .empty
        
        rivalCards.removeAll()
        playerCards.removeAll()
        cardsToDiscard.removeAll()
        
        hasMatchStarted = false
        hasMatchFinished = false
        showPlayAgainAlert = false
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
        unRevealAllPlayerCards()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dealCards()
            self.updatePoints()
        }
    }
    
    func toggleCardSelection(_ card: GameCharacter) {
        if let index = playerCards.firstIndex(where: { $0.id == card.id }) {
            withAnimation {
                playerCards[index].isSelected.toggle()
            }
            
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
        
        // Remove discarted cards from player, with animation
        withAnimation {
            playerCards.removeAll { card in
                cardsToDiscard.contains { $0.id == card.id }
            }
        }
        
        // Reset isSelected and return discarted cards to deck
        returnDiscardedCardsToDeck()
        
        // Animate shuffle cards
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldShuffleCards = true
            self.gameCharacters.shuffle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Deal new cards to empty indices
            for index in discardedIndices {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3) {
                    withAnimation {
                        if let newCard = self.gameCharacters.first {
                            newCardsToDeal.append(newCard)
                            self.playerCards.insert(newCard, at: index)
                            self.gameCharacters.removeFirst()
                        }
                    }
                }
            }
            
            let totalDelay = Double(discardedIndices.count) * 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + totalDelay) {
                self.revealAllPlayerCards()
                self.updatePoints()
            }
        }
    }
    
    // MARK: - Internal methods for game
    private func loadGameSettings() {
        isSoundEnabled = getSoundSetting()
        gamesToWin = getNumberOfGamesToWinSetting()
        setsToWin = getNumberOfSetsToWinSetting()
    }
    
    private func dealCards() {
        guard gameCharacters.count >= 6 else {
            debugPrint("Not enough cards to deal")
            return
        }
        
        gameCharacters.shuffle()
        dealCardsToRival()
        dealCardsToPlayer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.revealPlayerCardsAndUpdatePoints()
        }
    }
    
    private func dealCardsToRival() {
        for index in 0..<3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.2) {
                withAnimation {
                    self.rivalCards.append(self.gameCharacters.removeFirst())
                }
            }
        }
    }
    
    private func dealCardsToPlayer() {
        for index in 0..<3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 3) * 0.2) {
                withAnimation {
                    self.playerCards.append(self.gameCharacters.removeFirst())
                }
            }
        }
    }
    
    private func revealAllPlayerCards() {
        for index in playerCards.indices {
            playerCards[index].isRevealed = true
        }
        shouldRevealPlayerCards = true
    }
    
    private func unRevealAllPlayerCards() {
        for index in playerCards.indices {
            playerCards[index].isRevealed = false
        }
        shouldRevealPlayerCards = false
    }
    
    private func revealPlayerCardsAndUpdatePoints() {
        revealAllPlayerCards()
        updatePoints()
    }
    
    private func returnCardsToDeck() {
        unRevealAllPlayerCards()
        shouldRevealRivalCards = false
        
        withAnimation {
            gameCharacters.append(contentsOf: playerCards)
            gameCharacters.append(contentsOf: rivalCards)
            playerCards.removeAll()
            rivalCards.removeAll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldShuffleCards = true
        }
    }
    
    private func returnDiscardedCardsToDeck() {
        withAnimation {
            for var card in cardsToDiscard {
                card.isSelected = false
                card.isRevealed = false
                gameCharacters.append(card)
            }
            cardsToDiscard.removeAll()
        }
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
        if isSoundEnabled {
            playGameWonSound()
        }
        hasMatchFinished = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showPlayAgainAlert = true
        }
    }
    
    private func rivalHasWon() {
        gameTextMessage = .matchLost
        if isSoundEnabled {
            playGameLostSound()
        }
        hasMatchFinished = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showPlayAgainAlert = true
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
    
    private func resetScoreboard() {
        rivalPoints = 0
        playerPoints = 0
        rivalGames = 0
        playerGames = 0
        rivalSets = 0
        playerSets = 0
    }
    
    // MARK: - Match settings
    @Published var gamesToWin: Int = 2 {
        didSet {
            encodeAndSaveNumberOfGamesToWin()
        }
    }
    
    private let gamesToWinUserDefaultsKey: String = "gamesToWinSetting"
    
    private func encodeAndSaveNumberOfGamesToWin() {
        do {
            let encoded = try JSONEncoder().encode(gamesToWin)
            UserDefaults.standard.set(encoded, forKey: gamesToWinUserDefaultsKey)
        } catch {
            debugPrint("Error encoding number of games to win: \(error)")
        }
    }
    
    private func getNumberOfGamesToWinSetting() -> Int {
        if let gamesToWinSetting = UserDefaults.standard.object(forKey: gamesToWinUserDefaultsKey) as? Data {
            do {
                let gamesToWinSetting = try JSONDecoder().decode(Int.self, from: gamesToWinSetting)
                return gamesToWinSetting
            } catch {
                debugPrint("Error decoding number of games to win: \(error)")
            }
        }
        return 2 // default value if decoding fails
    }
    
    @Published var setsToWin: Int = 2 {
        didSet {
            encodeAndSaveNumberOfSetsToWin()
        }
    }
    
    private let setsToWinUserDefaultsKey: String = "setsToWinSetting"
    
    private func encodeAndSaveNumberOfSetsToWin() {
        do {
            let encoded = try JSONEncoder().encode(setsToWin)
            UserDefaults.standard.set(encoded, forKey: setsToWinUserDefaultsKey)
        } catch {
            debugPrint("Error encoding number of sets to win: \(error)")
        }
    }
    
    private func getNumberOfSetsToWinSetting() -> Int {
        if let setsToWinSetting = UserDefaults.standard.object(forKey: setsToWinUserDefaultsKey) as? Data {
            do {
                let setsToWinSetting = try JSONDecoder().decode(Int.self, from: setsToWinSetting)
                return setsToWinSetting
            } catch {
                debugPrint("Error decoding number of sets to win: \(error)")
            }
        }
        return 2 // default value if decoding fails
    }
    
    // MARK: - Sound settings
    @Published var isSoundEnabled: Bool = true {
        didSet {
            encodeAndSaveSoundSetting()
        }
    }
    
    private let soundUserDefaultsKey: String = "soundSetting"
    let gameWonSound = SoundModel(name: "gameWon")
    let gameLostSound = SoundModel(name: "gameLost")
    
    private func encodeAndSaveSoundSetting() {
        do {
            let encoded = try JSONEncoder().encode(isSoundEnabled)
            UserDefaults.standard.set(encoded, forKey: soundUserDefaultsKey)
        } catch {
            debugPrint("Error encoding sound setting: \(error)")
        }
    }
    
    private func getSoundSetting() -> Bool {
        if let soundSettingData = UserDefaults.standard.object(forKey: soundUserDefaultsKey) as? Data {
            do {
                let soundSetting = try JSONDecoder().decode(Bool.self, from: soundSettingData)
                return soundSetting
            } catch {
                debugPrint("Error decoding sound setting: \(error)")
            }
        }
        return true // default value if decoding fails
    }
    
    private let soundPlayer = SoundPlayer()
    
    private func playGameWonSound() {
        guard let url = gameWonSound.getURL() else {
            debugPrint("Game won sound URL is nil. Sound will not play.")
            return
        }
        soundPlayer.play(withURL: url)
    }
    
    private func playGameLostSound() {
        guard let url = gameLostSound.getURL() else {
            debugPrint("Game lost sound URL is nil. Sound will not play.")
            return
        }
        soundPlayer.play(withURL: url)
    }
    
    // MARK: - Methods for view
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
