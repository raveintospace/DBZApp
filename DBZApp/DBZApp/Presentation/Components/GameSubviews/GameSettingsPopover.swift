//
//  GameSettingsPopover.swift
//  DBZApp
//
//  Created by Uri on 12/12/24.
//

import SwiftUI
import SwiftfulRouting

struct GameSettingsPopover: View {
    
    @Environment(\.router) private var router
    @EnvironmentObject private var databaseViewModel: DatabaseViewModel
    @ObservedObject var viewModel: GameViewModel // Observes the existing viewModel
        
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            settingsPopoverTitle
            
            VStack(spacing: 12) {
                gamesSelector
                setsSelector
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ZStack {
            Color.dbzBlue.ignoresSafeArea()
            
            GameSettingsPopover(viewModel: GameViewModel(databaseViewModel: DeveloperPreview.instance.databaseViewModel))
                .environmentObject(DeveloperPreview.instance.databaseViewModel)
        }
    }
}

extension GameSettingsPopover {
    
    private var settingsPopoverTitle: some View {
        Text("SETTINGS")
            .font(.title)
            .bold()
            .foregroundStyle(.dbzYellow)
    }
    
    private var gamesSelector: some View {
        GameSegmentedControl(
            segmentedTitle: "Games to win",
            isEnabled: !viewModel.hasGameStarted,
            selection: $viewModel.gamesToWin
        )
        .padding()
    }
    
    private var setsSelector: some View {
        GameSegmentedControl(
            segmentedTitle: "Sets to win",
            isEnabled: !viewModel.hasGameStarted,
            selection: $viewModel.setsToWin
        )
        .padding()
    }
}
