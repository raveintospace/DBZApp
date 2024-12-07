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
    
    private var undealtCards: [GameCharacter] = [GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree, GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree, GameCharacter.mock, GameCharacter.mockTwo, GameCharacter.mockThree] // viewmodel.undealtcards
    
    @State private var liftedStates: [Bool]
    
    @State private var activeAlert: GameAlertType? = nil
    
    init(databaseViewModel: DatabaseViewModel) {
        _viewModel = StateObject(wrappedValue: GameViewModel(databaseViewModel: databaseViewModel))
        _liftedStates = State(initialValue: Array(repeating: false, count: undealtCards.count))
    }
    
    var body: some View {
        ZStack {
            gameWallpaper
            
            VStack {
                header
                Spacer()
                
                if viewModel.gameCharacters.isEmpty {
                    ProgressColorBarsView()
                } else {
                    bodyStack
                }
                
                Spacer()
                footer
            }
        }
        .alert(item: $activeAlert) { alertType in
            switch alertType {
            case .resetMatch:
                return resetMatchAlert()
            case .gameFinished:
                return playAgainAlert()
            }
        }
        .onChange(of: viewModel.hasGameFinished) { _, newValue in
            if newValue {
                activeAlert = .gameFinished
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
                router.dismissScreen()
            },
            onSettingsButtonPressed: {
                router.showModal(
                    transition: AnyTransition.scale.animation(.easeInOut),
                    backgroundColor: Color.black.opacity(0.001),
                    ignoreSafeArea: false) {
                        Text("This will be the settings menu")
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    }
            }
        )
        .padding(.horizontal)
    }
    
    private var bodyStack: some View {
        VStack {
            HStack {
                ForEach(viewModel.rivalCards) { card in
                    GameCard(name: card.name, imageName: card.image, kiPoints: card.kiToDisplayInGame, isRevealed: viewModel.shouldRevealRivalCards, isSelected: .constant(false))
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 0) {
                GamePileOfCards(undealtCards: undealtCards, shouldShuffleCards: $viewModel.shouldShuffleCards)
                    .frame(width: 70, alignment: .leading)
                GameInfoText(text: $viewModel.gameTextMessage)
                    .frame(maxWidth: .infinity, alignment: .center)
                gameTrailingButtons
                    .frame(width: 70, alignment: .trailing)
                    .background(.red)
                
            }
            .padding()
            .background(.brown)
            
            HStack {
                ForEach(viewModel.playerCards) { card in
                    GameCard(name: card.name, imageName: card.image, kiPoints: card.kiToDisplayInGame, isRevealed: viewModel.shouldRevealPlayerCards, isSelected: .constant(false))
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    
    private var gameTrailingButtons: some View {
        GameTrailingButtons(
            hasGameStarted: viewModel.hasGameStarted,
            hasGameFinished: viewModel.hasGameFinished,
            hasSelectedCards: true,
            areRivalCardsShown: viewModel.shouldRevealRivalCards,
            onPlayButtonPressed: {
                viewModel.startGame()
            },
            onRestartButtonPressed: {
                activeAlert = .resetMatch
            },
            onRevealButtonPressed: {
                // compete with rival - viewModel.revealCards()
                // disable button from viewmodel
                viewModel.compareCards()
            },
            onDealButtonPressed: {
                viewModel.playNextRound()
            },
            onConfirmButtonPressed: {
                // discard selected cards and deal new ones - cards onTapGesture update their position with y+3
            },
            onCancelButtonPressed: {
                // cancel cards to discard
            })
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
    
    private func showRivalPoints() -> String {
        viewModel.shouldRevealRivalCards ? viewModel.rivalPointsInView() : "¿?"
    }
    
    private func showPlayerPoints() -> String {
        viewModel.shouldRevealPlayerCards ? viewModel.playerPointsInView() : "¿?"
    }
    
    private func resetMatchAlert() -> Alert {
        return Alert(
            title: Text("Reset Match"),
            message: Text("Do you want to reset the current match?"),
            primaryButton: .default(Text("Cancel")),
            secondaryButton: .destructive(Text("Reset")) {
                viewModel.endGame()
        })
    }
    
    private func playAgainAlert() -> Alert {
        return Alert(
            title: Text("Match Finished"),
            message: Text("Do you want to play again?"),
            primaryButton: .default(Text("No")),
            secondaryButton: .destructive(Text("Yes")) {
                viewModel.endGame()
        })
    }
}


// MARK: - To Do
/*
 Update components to display info from viewmodel
 Fix size of hstack in bodystack when cards are not dealt & message updates, only happens with iphone
 
 */
