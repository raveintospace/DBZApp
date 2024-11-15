//
//  GameTrailingButtons.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameTrailingButtons: View {
    
    var hasGameStarted: Bool = false // viewModel.hasGameStarted
    var hasSelectedCards: Bool = false // !viewmodel.cardsToDiscardArray.isEmpty
    
    var onPlayButtonPressed: (() -> Void)? = nil
    var onRestartButtonPressed: (() -> Void)? = nil
    var onRevealButtonPressed: (() -> Void)? = nil
    var onConfirmButtonPressed: (() -> Void)? = nil
    var onCancelButtonPressed: (() -> Void)? = nil
    
    @State private var showPopover: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            topButton
            centerButton
            bottomButton
        }
    }
}

#Preview {
    HStack {
        GameTrailingButtons(hasGameStarted: false)
        GameTrailingButtons(hasGameStarted: true)
    }
}

extension GameTrailingButtons {
    private var topButton: some View {
        if hasGameStarted {
            GameActionButton(
                imageName: "arrow.clockwise",
                onButtonPressed: { onRestartButtonPressed?()}
            )
        } else {
            GameActionButton(
                imageName: "play.fill",
                onButtonPressed: { onPlayButtonPressed?()}
            )
        }
    }
    
    private var centerButton: some View {
        GameActionButton(
            imageName: "play.rectangle.on.rectangle",
            isEnabled: hasGameStarted,
            onButtonPressed: { onRevealButtonPressed?() }
        )
    }
    
    private var bottomButton: some View {
        GameActionButton(
            imageName: "tray.and.arrow.down",
            imageYOffset: -2,
            isEnabled: hasGameStarted,
            onButtonPressed: {
                showPopover.toggle()
            }
        )
        .popover(isPresented: $showPopover) {
            ZStack {
                Color.dbzBlue.opacity(0.5).ignoresSafeArea()
                
                VStack(spacing: 8) {
                    GameActionButton(imageName: "checkmark",
                                     isEnabled: hasSelectedCards,
                                     onButtonPressed: { onConfirmButtonPressed?()}
                    )
                    GameActionButton(imageName: "xmark",
                                     isEnabled: hasSelectedCards,
                                     onButtonPressed: { onCancelButtonPressed?()}
                    )
                }
                .padding(4)
            }
            .presentationCompactAdaptation(.popover)
        }
    }
}
