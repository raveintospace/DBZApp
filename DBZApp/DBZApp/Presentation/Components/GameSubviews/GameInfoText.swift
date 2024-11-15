//
//  GameInfoText.swift
//  DBZApp
//
//  Created by Uri on 15/11/24.
//

import SwiftUI

struct GameInfoText: View {
    
    var text: String = "Game Text"
    var fontName: String? = "SaiyanSans"
    var fontSize: CGFloat = 45
    var fontWeight: Font.Weight = .bold
    
    var body: some View {
        Text(text)
            .font(fontName != nil ? .custom(fontName!, size: fontSize) : .system(size: fontSize, weight: fontWeight))
            .kerning(1.5)
            .baselineOffset(-5)
            .foregroundStyle(.dbzYellow)
            .shadow(color: .dbzOrange, radius: 1, x: 0, y: 0)
            .shadow(color: .dbzOrange, radius: 2, x: 0, y: 0)
            .shadow(color: .dbzBlue, radius: 3, x: 0, y: 0)
    }
}

#Preview {
    GameInfoText()
}
