//
//  GamePileOfCards.swift
//  DBZApp
//
//  Created by Uri on 25/11/24.
//

import SwiftUI

struct GamePileOfCards: View {
    
    var undealtCards: [GameCharacter] = []
    @Binding var shouldShuffleCards: Bool
    
    // Properties for animation
    @State private var cardPositions: [CGSize] = []
    @State private var cardRotations: [Angle] = []
    @State private var isShuffling: Bool = false
    
    // Namespace to deal cards to players
    @Namespace private var cardAnimationNamespace
    
    var body: some View {
        ZStack {
            ForEach(undealtCards.indices, id: \.self) { index in
                GameCard(
                    name: undealtCards[index].name,
                    imageName: undealtCards[index].image,
                    kiPoints: undealtCards[index].kiToDisplayInGame,
                    isRevealed: false,
                    isSelected: .constant(false)
                )
                .offset(cardPositions.indices.contains(index) ? cardPositions[index] : .zero)
                .rotationEffect(cardRotations.indices.contains(index) ? cardRotations[index] : .zero)
                .animation(isShuffling ? .easeInOut(duration: 0.6) : .default, value: cardPositions)
                .matchedGeometryEffect(id: "card-\(index)", in: cardAnimationNamespace)
            }
        }
        .onAppear {
            setupInitialCardPositionsAndRotations()
        }
        .onChange(of: shouldShuffleCards) { _, newValue in
            if newValue {
                shuffleCards()
            }
        }
    }
}

#Preview {
    
    @Previewable @State var shouldShuffle: Bool = false
    
    let undealtCards: [GameCharacter] = [GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree, GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree, GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree]
    
    VStack(spacing: 20) {
        GamePileOfCards(undealtCards: undealtCards, shouldShuffleCards: $shouldShuffle)
            .frame(width: 140)
        
        Button("Shuffle") {
            shouldShuffle.toggle()
        }
    }
}

extension GamePileOfCards {
    private func shuffleCards() {
        isShuffling = true
        
        // Random positions & rotations to simulate shuffle
        let randomPositions: [CGSize] = undealtCards.map { _ in
            CGSize(width: CGFloat.random(in: -5...30),
                   height: CGFloat.random(in: -50...50))
        }
        let randomRotations: [Angle] = undealtCards.map { _ in
            Angle(degrees: Double.random(in: -15...15))
        }
        
        // Assign the random positions & rotations
        withAnimation(.easeInOut(duration: 0.3)) {
            cardPositions = randomPositions
            cardRotations = randomRotations
            
        }
        
        // Pile the cards after being shuffled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut(duration: 0.6)) {
                cardPositions = Array(repeating: .zero, count: undealtCards.count)
                cardRotations = Array(repeating: .zero, count: undealtCards.count)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                shouldShuffleCards = false
                isShuffling = false
            }
        }
    }
    
    private func setupInitialCardPositionsAndRotations() {
        cardPositions = Array(repeating: .zero, count: undealtCards.count)
        cardRotations = Array(repeating: .zero, count: undealtCards.count)
    }
}
