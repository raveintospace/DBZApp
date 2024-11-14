//
//  GameTrailingButtons.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameTrailingButtons: View {
    
    var hasGameStarted: Bool = false // viewModel.hasGameStarted
    
    var body: some View {
        VStack(spacing: 8) {
            GameActionButton(imageName: "play.fill")
            GameActionButton(imageName: "arrow.clockwise")
            GameActionButton(imageName: "play.rectangle.on.rectangle")
            GameActionButton(imageName: "tray.and.arrow.down", imageYOffset: -2)
            GameActionButton(imageName: "checkmark")
            GameActionButton(imageName: "xmark")
        }
    }
}

#Preview {
    GameTrailingButtons()
}

extension GameTrailingButtons {
    private var topButton: some View {
        GameActionButton(imageName: "play.fill")
    }
}
