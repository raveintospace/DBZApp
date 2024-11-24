//
//  GameCard.swift
//  DBZApp
//  https://youtu.be/n1qabtjZ_jg?si=rtl9vzA_eK7kJaI4 - Memoroji
//  Created by Uri on 16/11/24.
//

import SwiftUI

struct GameCard: View {
    
    var name: String = GameCharacter.mock.name
    var imageName: String = GameCharacter.mock.image
    var kiPoints: String = GameCharacter.mock.kiToDisplayInGame
    var isRevealed: Bool = false
    
    var aspectRatio: CGFloat = 2/3
    var contentMode: ContentMode = .fit
    var cornerRadius: CGFloat = 15
    var strokeBorder: CGFloat = 3
    var lineLimit: Int = 2
    
    var body: some View {
        ZStack {
            if isRevealed {
                cardCanva(revealedGameCardLogo, borderColor: .dbzBlue)
                cardCharacter
            } else {
                cardCanva(unrevealedGameCardLogo, borderColor: .dbzOrange)
            }
        }
        .aspectRatio(aspectRatio, contentMode: contentMode)
    }
}

#Preview {
    ScrollView(.vertical) {
        VStack(spacing: 10) {
            GameCard(isRevealed: true)
            GameCard(isRevealed: false)
            HStack {
                GameCard(name: GameCharacter.mock.name, imageName: GameCharacter.mock.image, kiPoints: "999.999.999", isRevealed: true)
                GameCard(name: GameCharacter.mockTwo.name, imageName: GameCharacter.mockTwo.image, kiPoints: GameCharacter.mockTwo.kiToDisplayInGame, isRevealed: true)
                GameCard(name: "dsfdaifajodsaipa", imageName: GameCharacter.mockThree.image, kiPoints: GameCharacter.mockThree.kiToDisplayInGame, isRevealed: true)
            }
            .padding(.vertical)
        }
    }
    .padding()
}

extension GameCard {
    private func cardCanva(_ background: some View, borderColor: Color) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(lineWidth: strokeBorder)
            .background(
                background
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            )
            .foregroundStyle(borderColor)
    }
    
    private var revealedGameCardLogo: some View {
        ZStack {
            Color.dbzOrange
            Image("gameCardBlackLogo")
                .resizable()
                .scaledToFit()
                .opacity(0.15)
        }
    }
    
    private var cardCharacter: some View {
        VStack(spacing: 0) {
            nameSection
                .padding(.horizontal, 4)
            ImageLoaderView(url: imageName)
                .padding(.vertical, 4)
            kiSection
                .padding(.horizontal, 4)
        }
        .foregroundStyle(.black)
        .padding()
    }
    
    private var nameSection: some View {
        Text(name.uppercased())
            .font(.caption2)
            .lineLimit(lineLimit)
            .multilineTextAlignment(.center)
            .bold()
    }
    
    private var kiSection: some View {
        VStack {
            Text("Ki points")
                .fontWeight(.semibold)
            Text(kiPoints)
        }   
        .font(.caption2)
        .lineLimit(lineLimit)
        .multilineTextAlignment(.center)
    }
    
    private var unrevealedGameCardLogo: some View {
        ZStack {
            Color.dbzBlue
            Image("gameCardYellowLogo")
                .resizable()
                .scaledToFit()
        }
    }
}


// create a view (GameCardDeck) for the Zstack of cards and test the animation with a bool shouldShuffle
