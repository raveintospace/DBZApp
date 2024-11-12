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
            
            if viewModel.gameCharacters.isEmpty {
                ProgressColorBarsView()
            } else {
                VStack {
                    Text("GameViewModel characters: \(viewModel.gameCharacters.count)")
                    Text(viewModel.gameCharacters[0].name)
                    Text(viewModel.gameCharacters[10].name)
                }
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
        .padding()
        .padding(.top, -10)
    }
}
