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
    
    @State private var shouldShuffle: Bool = false // viewmodel.shouldShuffle
    @State private var liftedStates: [Bool]
    @State private var shouldRevealCards: Bool = false // viewmodel.shouldRevealCards
    
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
            
            HStack(spacing: 0) {
                // should be a gameZstack
                GamePileOfCards(undealtCards: undealtCards, shouldShuffleCards: $shouldShuffle)
                    .frame(width: 70, alignment: .leading)
                GameInfoText(text: .constant(.matchWon))
                    .frame(maxWidth: .infinity, alignment: .center)
                gameTrailingButtons
                    .frame(width: 70, alignment: .trailing)
                
            }
            .padding()
            
            HStack {
                ForEach(viewModel.playerCards) { card in
                    GameCard(name: card.name, imageName: card.image, kiPoints: card.kiToDisplayInGame, isRevealed: viewModel.shouldRevealPlayerCards, isSelected: .constant(false))
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var gameTrailingButtons: some View {
        GameTrailingButtons(
            hasGameStarted: true,
            hasGameFinished: false,
            hasSelectedCards: true,
            areRivalCardsShown: false,
            onPlayButtonPressed: {
                // start playing
            },
            onRestartButtonPressed: {
                viewModel.testDealAndUpdate()
            },
            onRevealButtonPressed: {
                // compete with rival - viewModel.revealCards()
                // disable button from viewmodel
                shouldRevealCards.toggle()
            },
            onDealButtonPressed: {
                // deal new cards
            },
            onConfirmButtonPressed: {
                // discard selected cards and deal new ones - cards onTapGesture update their position with y+3
                shouldShuffle.toggle()
            },
            onCancelButtonPressed: {
                // cancel cards to discard
            })
    }
    
    private var footer: some View {
        VStack {
            GameFooterBar(
                rivalRectangleFigures: "150.000.000.000",
                playerRectangleFigures: "15 Septillion",
                leftRectangleFigures: "R-1 / P-1",
                centerRectangleFigures: "R-1 / P-1",
                rightRectangleFigures: "0 / 3"
            )
            
        }
        .padding(.horizontal)
    }
}


// MARK: - To Do
/*
 Update components to display info from viewmodel
 */
