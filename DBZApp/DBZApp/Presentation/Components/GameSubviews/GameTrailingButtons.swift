//
//  GameTrailingButtons.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameTrailingButtons: View {
    
    var hasMatchStarted: Bool = false
    var hasMatchFinished: Bool = false
    var hasSelectedCards: Bool = false
    var areDiscardsAllowed: Bool = false
    var areRivalCardsShown: Bool = false
    var arePlayerCardsShown: Bool = false
    
    var onPlayButtonPressed: (() -> Void)? = nil
    var onStopButtonPressed: (() -> Void)? = nil
    var onRevealButtonPressed: (() -> Void)? = nil
    var onDealButtonPressed: (() -> Void)? = nil
    var onDiscardButtonPressed: (() -> Void)? = nil
    
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
        GameTrailingButtons(hasMatchStarted: false)
        GameTrailingButtons(hasMatchStarted: true)
        GameTrailingButtons(hasMatchStarted: true, hasSelectedCards: true, areRivalCardsShown: true)
        GameTrailingButtons(hasMatchStarted: false, hasMatchFinished: true, hasSelectedCards: true, areDiscardsAllowed: true)
        GameTrailingButtons(hasMatchStarted: false, hasMatchFinished: true, hasSelectedCards: true, areDiscardsAllowed: false, areRivalCardsShown: false)
    }
}

extension GameTrailingButtons {
    private var topButton: some View {
        if hasMatchStarted && !hasMatchFinished {
            GameActionButton(
                imageName: "stop.fill",
                onButtonPressed: { onStopButtonPressed?() }
            )
        } else {
            GameActionButton(
                imageName: "play.fill",
                isEnabled: !hasMatchFinished,
                onButtonPressed: { onPlayButtonPressed?()}
            )
        }
    }
    
    private var centerButton: some View {
        if areRivalCardsShown {
            GameActionButton(
                imageName: "play.rectangle",
                isEnabled: hasMatchStarted && !hasMatchFinished,
                onButtonPressed: { onDealButtonPressed?() }
            )
        } else {
            GameActionButton(
                imageName: "play.rectangle.on.rectangle",
                isEnabled: hasMatchStarted && !hasMatchFinished && arePlayerCardsShown,
                onButtonPressed: { onRevealButtonPressed?() }
            )
        }
    }
    
    private var bottomButton: some View {
        GameActionButton(
            imageName: "arrow.2.circlepath",
            isEnabled: hasSelectedCards && areDiscardsAllowed && !areRivalCardsShown,
            onButtonPressed: { onDiscardButtonPressed?() }
        )
    }
}
