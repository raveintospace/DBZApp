//
//  GameInfoText.swift
//  DBZApp
//
//  Created by Uri on 15/11/24.
//

import SwiftUI

struct GameInfoText: View {
    
    var text: GameText = .empty
    var fontName: String? = "SaiyanSans"
    var fontSize: CGFloat = 70
    var fontWeight: Font.Weight = .bold
    
    @State private var isVisible: Bool = false
    
    var body: some View {
        Text(text.message)
            .font(fontName != nil ? .custom(fontName!, size: fontSize) : .system(size: fontSize, weight: fontWeight))
            .kerning(1.5)
            .baselineOffset(-5)
            .multilineTextAlignment(.center)
            .foregroundStyle(.dbzYellow)
            .shadow(color: .dbzOrange, radius: 1, x: 0, y: 0)
            .shadow(color: .dbzOrange, radius: 2, x: 0, y: 0)
            .shadow(color: .dbzBlue, radius: 3, x: 0, y: 0)
            .opacity(isVisible ? 1 : 0)
            .scaleEffect(isVisible ? 1 : 0.3)
            .offset(y: isVisible ? 0 : 30)
            .animation(.easeOut(duration: 0.65), value: isVisible)
            .onAppear {
                withAnimation {
                    isVisible = true
                }
            }
            .onDisappear {
                withAnimation {
                    isVisible = false
                }
            }
    }
}

#Preview {
    ScrollView(.vertical) {
        GameInfoText(text: .gameWon)
        GameInfoText(text: .gameLost)
        GameInfoText(text: .setWon)
        GameInfoText(text: .setLost)
        GameInfoText(text: .matchWon)
        GameInfoText(text: .matchLost)
        GameInfoText(text: .draw)
        GameInfoText(text: .welcome)
    }
}

// fer un onAppear pq l'escala passi de 0 a 1 i alguna animacio mes
// multilinetext center
