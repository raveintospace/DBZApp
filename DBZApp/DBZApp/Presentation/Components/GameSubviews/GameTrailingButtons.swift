//
//  GameTrailingButtons.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameTrailingButtons: View {
    
    var hasGameStarted: Bool = false // viewModel.hasGameStarted
    var hasGameFinished: Bool = false // viewModel.hasGameFinished
    var hasSelectedCards: Bool = false // !viewModel.cardsToDiscardArray.isEmpty
    var areRivalCardsShown: Bool = false  // viewModel.areRivalCardsShown
    
    var onPlayButtonPressed: (() -> Void)? = nil
    var onRestartButtonPressed: (() -> Void)? = nil
    var onRevealButtonPressed: (() -> Void)? = nil
    var onDealButtonPressed: (() -> Void)? = nil
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
        GameTrailingButtons(hasGameStarted: true, hasSelectedCards: true, areRivalCardsShown: true)
        GameTrailingButtons(hasGameStarted: false, hasGameFinished: true)
    }
}

extension GameTrailingButtons {
    private var topButton: some View {
        if hasGameStarted || hasGameFinished {
            GameActionButton(
                imageName: "arrow.2.circlepath",
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
        if areRivalCardsShown {
            GameActionButton(
                imageName: "play.rectangle",
                isEnabled: hasGameStarted && !hasGameFinished,
                onButtonPressed: { onDealButtonPressed?() }
            )
        } else {
            GameActionButton(
                imageName: "play.rectangle.on.rectangle",
                isEnabled: hasGameStarted && !hasGameFinished,
                onButtonPressed: { onRevealButtonPressed?() }
            )
        }
    }
    
    private var bottomButton: some View {
        GameActionButton(
            imageName: "tray.and.arrow.down",
            imageYOffset: -3,
            isEnabled: hasGameStarted && !hasGameFinished,
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
