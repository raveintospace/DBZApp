//
//  GameView.swift
//  DBZApp
//
//  Created by Uri on 1/11/24.
//

import SwiftUI
import SwiftfulRouting

struct GameView: View {
    
    @Environment(\.router) private var router
    @EnvironmentObject private var databaseViewModel: DatabaseViewModel
    @StateObject private var viewModel: GameViewModel
    
    // Track cards' positions
    @State private var rivalCardPositions: [CGRect] = Array(repeating: .zero, count: 3)
    @State private var playerCardPositions: [CGRect] = Array(repeating: .zero, count: 3)
    
    @Namespace private var cardAnimationNamespace
    
    @State private var activeAlert: GameAlert? = nil
    
    init(databaseViewModel: DatabaseViewModel) {
        _viewModel = StateObject(wrappedValue: GameViewModel(databaseViewModel: databaseViewModel))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let cardHeight = max(100, screenHeight * (isSmallScreen ? 0.19 : 0.23))
            let dynamicFontSize: CGFloat = isSmallScreen ? 60 : 70
            
            ZStack {
                gameWallpaper
                
                VStack {
                    header
                    Spacer()
                    
                    if viewModel.gameCharacters.isEmpty {
                        ProgressColorBarsView()
                    } else {
                        bodyStack(cardHeight: cardHeight, gameInfoTextFontSize: dynamicFontSize)
                    }
                    
                    Spacer()
                    footer
                }
            }
        }
        .alert(item: $activeAlert) { alertType in
            switch alertType {
            case .finishMatch:
                return finishMatchAlert()
            case .playAgain:
                return playAgainAlert()
            case .abandonModule:
                return abandonModuleAlert()
            }
        }
        .onChange(of: viewModel.showPlayAgainAlert) { _, newValue in
            if newValue {
                activeAlert = .playAgain
            }
        }
    }
}

#Preview {
    RouterView { _ in
        GameView(databaseViewModel: DeveloperPreview.instance.databaseViewModel)
            .environmentObject(DeveloperPreview.instance.databaseViewModel)
    }
}

extension GameView {
    
    private var gameWallpaper: some View {
        Image("gameWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var header: some View {
        GameHeaderBar(
            onHomeButtonPressed: {
                viewModel.hasMatchStarted ? activeAlert = .abandonModule : router.dismissScreen()
            },
            onSettingsButtonPressed: {
                router.showModal(
                    transition: AnyTransition.scale.animation(.easeInOut),
                    backgroundColor: Color.black.opacity(0.001),
                    ignoreSafeArea: false) {
                        settingsPopover
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    }
            }
        )
        .padding(.horizontal)
    }
    
    private func bodyStack(cardHeight: CGFloat, gameInfoTextFontSize: CGFloat) -> some View {
        ZStack {
            centralHStack(gameInfoTextFontSize: gameInfoTextFontSize)
            
            VStack {
                rivalHStack(cardHeight: cardHeight)
                Spacer()
                playerHStack(cardHeight: cardHeight)
            }
        }
    }
    
    private func rivalHStack(cardHeight: CGFloat) -> some View {
        HStack {
            ForEach(Array(viewModel.rivalCards.enumerated()), id: \.element.id) { index, card in
                GameCard(
                    name: card.name,
                    imageName: card.image,
                    kiPoints: card.kiToDisplayInGame,
                    isRevealed: viewModel.shouldRevealRivalCards,
                    isSelected: .constant(false)
                )
                .modifier(CardPositionModifier(index: index, positions: $rivalCardPositions))
                .matchedGeometryEffect(id: card.id, in: cardAnimationNamespace)
            }
        }
        .frame(height: cardHeight)
        .padding(.horizontal)
        .padding(.top)
    }
    
    private func centralHStack(gameInfoTextFontSize: CGFloat) -> some View {
        HStack(spacing: 0) {
            GamePileOfCards(
                undealtCards: viewModel.gameCharacters,
                shouldShuffleCards: $viewModel.shouldShuffleCards,
                namespace: cardAnimationNamespace
            )
            .frame(width: 70, alignment: .leading)
            
            GameInfoText(text: $viewModel.gameTextMessage, fontSize: gameInfoTextFontSize)
                .frame(maxWidth: .infinity, alignment: .center)
            
            gameTrailingButtons
                .frame(width: 70, alignment: .trailing)
        }
        .padding()
    }
    
    private var gameTrailingButtons: some View {
        GameTrailingButtons(
            hasMatchStarted: viewModel.hasMatchStarted,
            hasMatchFinished: viewModel.hasMatchFinished,
            hasSelectedCards: !viewModel.cardsToDiscard.isEmpty,
            areDiscardsAllowed: viewModel.areDiscardsAllowed(),
            areRivalCardsShown: viewModel.shouldRevealRivalCards,
            arePlayerCardsShown: viewModel.shouldRevealPlayerCards,
            onPlayButtonPressed: {
                viewModel.startMatch()
            },
            onStopButtonPressed: {
                activeAlert = .finishMatch
            },
            onRevealButtonPressed: {
                viewModel.compareCards()
            },
            onDealButtonPressed: {
                viewModel.playNextRound()
            },
            onDiscardButtonPressed: {
                viewModel.discardCardsAndDealNewOnes()
            })
    }
    
    private func playerHStack(cardHeight: CGFloat) -> some View {
        HStack {
            ForEach(Array(viewModel.playerCards.enumerated()), id: \.element.id) { index, card in
                GameCard(
                    name: card.name,
                    imageName: card.image,
                    kiPoints: card.kiToDisplayInGame,
                    isRevealed: card.isRevealed,
                    areRivalCardsRevealed: viewModel.shouldRevealRivalCards,
                    areDiscardsAllowed: viewModel.areDiscardsAllowed(),
                    isSelected: Binding(
                        get: { card.isSelected },
                        set: { newValue in
                            viewModel.toggleCardSelection(card)
                        }
                    )
                )
                .modifier(CardPositionModifier(index: index, positions: $playerCardPositions))
                .matchedGeometryEffect(id: card.id, in: cardAnimationNamespace)
            }
        }
        .frame(height: cardHeight)
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    private var footer: some View {
        VStack {
            GameFooterBar(
                rivalRectangleFigures: showRivalPoints(),
                playerRectangleFigures: showPlayerPoints(),
                leftRectangleFigures: "R-\(viewModel.rivalGames) / P-\(viewModel.playerGames)",
                centerRectangleFigures: "R-\(viewModel.rivalSets) / P-\(viewModel.playerSets)",
                rightRectangleFigures: "\(viewModel.discardsUsed) / \(viewModel.discardsAllowed)"
            )
            
        }
        .padding(.horizontal)
    }
    
    private var settingsPopover: some View {
        GameSettingsPopover(viewModel: viewModel)
            .padding(.vertical)
            .withBorder(color: .dbzYellow, width: 4, cornerRadius: 20)
            .background(.dbzBlue)
            .cornerRadius(20)
    }
    
    private func showRivalPoints() -> String {
        viewModel.shouldRevealRivalCards ? viewModel.rivalPointsInView() : "¿?"
    }
    
    private func showPlayerPoints() -> String {
        viewModel.shouldRevealPlayerCards ? viewModel.playerPointsInView() : "¿?"
    }
    
    private func finishMatchAlert() -> Alert {
        return Alert(
            title: Text("Finish Match"),
            message: Text("Do you want to finish the current match?"),
            primaryButton: .default(Text("No")),
            secondaryButton: .destructive(Text("Yes")) {
                viewModel.endMatch()
        })
    }
    
    private func playAgainAlert() -> Alert {
        return Alert(
            title: Text("Match Finished"),
            message: Text("Do you want to play again?"),
            primaryButton: .default(Text("No")) {
                router.dismissScreen()
            },
            secondaryButton: .destructive(Text("Yes")) {
                viewModel.endMatch()
        })
    }
    
    private func abandonModuleAlert() -> Alert {
        return Alert(
            title: Text("Match in progress"),
            message: Text("Do you want to leave the game module?"),
            primaryButton: .default(Text("No")),
            secondaryButton: .destructive(Text("Yes")) {
                router.dismissScreen()
        })
    }
    
    private var isSmallScreen: Bool {
        UIScreen.main.bounds.height < 700
    }
}


// MARK: - To Do
/*
 */
