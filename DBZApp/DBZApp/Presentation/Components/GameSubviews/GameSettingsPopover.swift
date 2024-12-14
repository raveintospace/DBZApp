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
    
    @State private var showDisabledAlert: Bool = false
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            settingsPopoverTitle
            
            VStack(spacing: 30) {
                gamesSelector
                setsSelector
                soundToggle
            }
            .padding()
        }
        .alert(isPresented: $showDisabledAlert) {
            Alert(title: Text("Setting disabled"), message: Text("You can only update settings when game has not started"), dismissButton: .default(Text("OK")))
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
            disabledAction: { showDisabledAlert = true },
            selection: $viewModel.gamesToWin
        )
    }
    
    private var setsSelector: some View {
        GameSegmentedControl(
            segmentedTitle: "Sets to win",
            isEnabled: !viewModel.hasGameStarted,
            disabledAction: { showDisabledAlert = true },
            selection: $viewModel.setsToWin
        )
    }
    
    private var soundToggle: some View {
        Toggle("Sound FX", isOn: $viewModel.isSoundEnabled)
            .font(.title2)
            .bold()
            .foregroundStyle(.dbzYellow)
    }
}
