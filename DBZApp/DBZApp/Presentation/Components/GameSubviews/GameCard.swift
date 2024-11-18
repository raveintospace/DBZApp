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
    
    var body: some View {
        ZStack {
            if isRevealed {
                frontCard
                cardContent
            } else {
                backCard
            }
        }
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
    private var frontCard: some View {
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(lineWidth: 5)
            .background(
                revealedGameCardLogo
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
            .foregroundStyle(.dbzBlue)
    }
    
    private var revealedGameCardLogo: some View {
        ZStack {
            Color.dbzOrange
            Image("gameCardBlackLogo")
                .resizable()
                .scaledToFit()
        }
    }
    
    private var cardContent: some View {
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
            .lineLimit(2)
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
    
    private var backCard: some View {
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(lineWidth: 5)
            .background(
                unrevealedGameCardLogo
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
            .foregroundStyle(.dbzOrange)
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
