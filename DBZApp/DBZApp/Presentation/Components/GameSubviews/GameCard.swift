//
//  GameCard.swift
//  DBZApp
//  https://youtu.be/n1qabtjZ_jg?si=rtl9vzA_eK7kJaI4 - Memoroji
//  Created by Uri on 16/11/24.
//

import SwiftUI
import SwiftfulUI

struct GameCard: View {
    
    var name: String = GameCharacter.mock.name
    var imageName: String = GameCharacter.mock.image
    var kiPoints: String = GameCharacter.mock.kiToDisplayInGame
    var isRevealed: Bool
    
    var aspectRatio: CGFloat = 2/3
    var contentMode: ContentMode = .fit
    var cornerRadius: CGFloat = 15
    var strokeBorder: CGFloat = 3
    var lineLimit: Int = 2
    
    @Binding var isSelected: Bool
    
    @State private var trigger: Bool = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            cardCanva(unrevealedGameCardLogo, borderColor: .dbzOrange)
                .opacity(isRevealed ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isRevealed ? 90 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            if isRevealed {
                cardCanva(revealedGameCardLogo, borderColor: .dbzBlue)
                    .overlay(cardCharacter)
                    .opacity(isRevealed ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(isRevealed ? 0 : -90),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
        }
        .aspectRatio(aspectRatio, contentMode: contentMode)
        .offset(y: isSelected ? -15 : 0)
        .animation(.spring(duration: 0.2), value: isSelected)
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2), value: isRevealed)
        .sensoryFeedback(.impact, trigger: trigger)
        .withTrigger(trigger: $trigger) {
            if isRevealed {
                isSelected.toggle()
            }
        }
    }
}

#Preview {
    @Previewable @State var isSelected: Bool = false
    @Previewable @State var isSelected2: Bool = false
    @Previewable @State var isSelected3: Bool = false
    
    @Previewable @State var isRevealed1: Bool = true
    @Previewable @State var isRevealed2: Bool = false
    
    ScrollView(.vertical) {
        VStack(spacing: 10) {
            GameCard(isRevealed: true, isSelected: $isSelected)
            GameCard(isRevealed: isRevealed2, isSelected: .constant(false))
            
            Button("Reveal") {
                isRevealed2.toggle()
            }
            
            HStack {
                GameCard(name: GameCharacter.mock.name, imageName: GameCharacter.mock.image, kiPoints: "999.999.999", isRevealed: true, isSelected: $isSelected)
                GameCard(name: GameCharacter.mockTwo.name, imageName: GameCharacter.mockTwo.image, kiPoints: GameCharacter.mockTwo.kiToDisplayInGame, isRevealed: true, isSelected: $isSelected2)
                GameCard(name: "dsfdaifajodsaipa", imageName: GameCharacter.mockThree.image, kiPoints: GameCharacter.mockThree.kiToDisplayInGame, isRevealed: true, isSelected: $isSelected3)
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
                .padding(4)
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
