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
    
    var body: some View {
        ZStack {
            backgroundRoundedRectangle
            cardContent
        }
    }
}

#Preview {
    GameCard()
        .padding()
}

extension GameCard {
    private var backgroundRoundedRectangle: some View {
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(lineWidth: 5)
            .background(
                gameCardLogo
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
            .foregroundStyle(.dbzBlue)
    }
    
    private var gameCardLogo: some View {
        ZStack {
            Color.dbzOrange.opacity(0.75)
            Image("gameCardLogo")
                .resizable()
                .scaledToFit()
                .opacity(0.15)
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
}
