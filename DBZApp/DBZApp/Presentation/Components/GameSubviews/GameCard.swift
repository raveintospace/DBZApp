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
    
    private var isJoker: Bool {
        kiPoints.lowercased() == "unknown"
    }
    
    private var isMalus: Bool {
        kiPoints.lowercased().contains("googolplex")
    }
    
    private var cardBackgroundColor: Color {
        if isJoker {
            return .green
        } else if isMalus {
            return .red
        } else {
            return .dbzOrange
        }
    }
    
    var body: some View {
        ZStack {
            EmptyView()
        }
        .cardFlipModifier(isRevealed: isRevealed) {
            revealedSide
        } back: {
            unrevealedSide
        }
        .aspectRatio(aspectRatio, contentMode: contentMode)
        .offset(y: isSelected ? -15 : 0)
        .animation(.spring(duration: 0.2), value: isSelected)
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
    
    @Previewable @State var isRevealed1: Bool = false
    @Previewable @State var isRevealed2: Bool = false
    
    ScrollView(.vertical) {
        VStack(spacing: 10) {
            GameCard(kiPoints: "unknown", isRevealed: true, isSelected: $isSelected)
            GameCard(isRevealed: isRevealed2, isSelected: .constant(false))
            
            Button("Reveal") {
                isRevealed1.toggle()
                isRevealed2.toggle()
            }
            
            HStack {
                GameCard(name: GameCharacter.mock.name, imageName: GameCharacter.mock.image, kiPoints: "unknown", isRevealed: isRevealed1, isSelected: $isSelected)
                GameCard(name: GameCharacter.mockTwo.name, imageName: GameCharacter.mockTwo.image, kiPoints: "969 Googolplex", isRevealed: true, isSelected: $isSelected2)
                GameCard(name: "dsfdaifajodsaipa", imageName: GameCharacter.mockThree.image, kiPoints: GameCharacter.mockThree.kiToDisplayInGame, isRevealed: true, isSelected: $isSelected3)
            }
            .padding(.vertical)
        }
    }
    .padding()
}

extension GameCard {
    private var unrevealedSide: some View {
        cardCanva(background: unrevealedGameCardLogo, borderColor: .dbzOrange)
    }
    
    private var revealedSide: some View {
        cardCanva(background: revealedGameCardLogo, borderColor: .dbzBlue)
            .overlay(cardCharacter)
    }
    
    private func cardCanva(background: some View, borderColor: Color) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(lineWidth: strokeBorder)
            .background(
                background
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            )
            .foregroundStyle(borderColor)
    }
    
    private var unrevealedGameCardLogo: some View {
        ZStack {
            Color.dbzBlue
            Image("gameCardYellowLogo")
                .resizable()
                .scaledToFit()
        }
    }
    
    private var revealedGameCardLogo: some View {
        ZStack {
            cardBackgroundColor
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
            Spacer()
            ImageLoaderView(url: imageName)
                .padding(4)
            Spacer()
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
            Text(kiPoints.capitalized)
        }
        .font(.caption2)
        .lineLimit(lineLimit)
        .multilineTextAlignment(.center)
    }
}
