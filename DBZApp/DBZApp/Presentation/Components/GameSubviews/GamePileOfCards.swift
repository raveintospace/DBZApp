//
//  GamePileOfCards.swift
//  DBZApp
//
//  Created by Uri on 25/11/24.
//

import SwiftUI

struct GamePileOfCards: View {
    
    var undealtCards: [GameCharacter] = []
    
    var body: some View {
        ZStack {
            ForEach(undealtCards) { card in
                GameCard(name: card.name, imageName: card.image ,kiPoints: card.kiToDisplayInGame, isRevealed: false)
            }
        }
    }
}

#Preview {
    let undealtCards: [GameCharacter] = [GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree]
    
    GamePileOfCards(undealtCards: undealtCards)
}
