//
//  GameInfoText.swift
//  DBZApp
//
//  Created by Uri on 15/11/24.
//

import SwiftUI

struct GameInfoText: View {
    
    @Binding var text: GameText
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
                    isVisible = text != .empty
                }
            }
            .onDisappear {
                withAnimation {
                    isVisible = false
                }
            }
            .onChange(of: text) { _, newText in
                withAnimation {
                    isVisible = newText != .empty
                }
            }
    }
}

#Preview {
    ScrollView(.vertical) {
        GameInfoText(text: .constant(.gameWon))
        GameInfoText(text: .constant(.gameLost))
        GameInfoText(text: .constant(.setWon))
        GameInfoText(text: .constant(.setLost))
        GameInfoText(text: .constant(.matchWon))
        GameInfoText(text: .constant(.matchLost))
        GameInfoText(text: .constant(.draw))
        GameInfoText(text: .constant(.welcome))
    }
}
