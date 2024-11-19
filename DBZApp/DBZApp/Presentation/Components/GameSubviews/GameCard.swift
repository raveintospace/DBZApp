//
//  GameCard.swift
//  DBZApp
//  https://youtu.be/n1qabtjZ_jg?si=rtl9vzA_eK7kJaI4 - 1h09m - finish !isRevealed
//  Created by Uri on 16/11/24.
//

import SwiftUI

struct GameCard: View {
    
    var name: String = GameCharacter.mock.name
    var imageName: String = GameCharacter.mock.image
    var kiPoints: String = GameCharacter.mock.ki
    var isRevealed: Bool = false
    
    var aspectRatio: CGFloat = 2/3
    var contentMode: ContentMode = .fit
    var cornerRadius: CGFloat = 25
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
    HStack {
        GameCard(isRevealed: true)
        GameCard(isRevealed: false)
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
        }
    }
    
    private var cardCharacter: some View {
        VStack(spacing: 0) {
            nameSection
                .frame(alignment: .top)
            ImageLoaderView(url: imageName)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            kiSection
                .frame(alignment: .bottom)
        }
        .foregroundStyle(.accent)
        .padding()
    }
    
    private var nameSection: some View {
        Text(name.uppercased())
            .lineLimit(lineLimit)
            .multilineTextAlignment(.center)
            .font(.title2)
            .bold()
    }
    
    private var kiSection: some View {
        VStack {
            Text("Ki points")
                .font(.title3)
                .fontWeight(.semibold)
            Text(kiPoints)
        }
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
