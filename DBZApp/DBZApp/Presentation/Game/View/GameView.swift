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
    
    init(databaseViewModel: DatabaseViewModel) {
        _viewModel = StateObject(wrappedValue: GameViewModel(databaseViewModel: databaseViewModel))
    }
    
    var body: some View {
        ZStack {
            
            gameWallpaper
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
            
            bodyStack
            
            footer
                .frame(maxHeight: .infinity, alignment: .bottom)
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
        .padding()
        .padding(.top, -10)
    }
    
    private var bodyStack: some View {
        HStack(spacing: 0) {
            if viewModel.gameCharacters.isEmpty {
                ProgressColorBarsView()
            } else {
                gameTrailingButtons
                    .frame(width: 70, alignment: .leading)
                    .background(.green)
                GameInfoText(text: .matchLost)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.red)
                gameTrailingButtons
                    .frame(width: 70, alignment: .trailing)
                    .background(.green)
            }
        }
        .padding()
    }
    
    private var gameTrailingButtons: some View {
        GameTrailingButtons(
            hasGameStarted: true,
            hasGameFinished: false,
            hasSelectedCards: false,
            areRivalCardsShown: false,
            onPlayButtonPressed: {
                // start playing
            },
            onRestartButtonPressed: {
                // restart playing
            },
            onRevealButtonPressed: {
                // compete with rival
            },
            onDealButtonPressed: {
                // deal new cards
            },
            onConfirmButtonPressed: {
                // discard selected cards and deal new ones
            },
            onCancelButtonPressed: {
                // cancel cards to discard
            })
    }
    
    private var footer: some View {
        GameFooterBar(
            rivalRectangleFigures: "150.000.000.000",
            playerRectangleFigures: "15 Septillion",
            leftRectangleFigures: "R-1 / P-1",
            centerRectangleFigures: "R-1 / P-1",
            rightRectangleFigures: "0 / 3"
        )
        .padding()
    }
}

/*
 VStack {
 //                    Text("GameViewModel characters: \(viewModel.gameCharacters.count)")
 //                    Text(viewModel.gameCharacters[0].name)
 //                    Text(viewModel.gameCharacters[10].name)
 //                }
 */
