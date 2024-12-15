//
//  GameRulesNavigationLink.swift
//  DBZApp
//
//  Created by Uri on 15/12/24.
//

import SwiftUI

struct GameRulesNavigationLink: View {
    
    var onNavigationPressed: (() -> Void)? = nil
    @State private var trigger = false
    
    var body: some View {
        HStack {
            NavigationLink("Game rules", destination: GameRulesView())
            Spacer()
            Image(systemName: "book.pages")
        }
        .font(.title2)
        .bold()
        .foregroundStyle(.dbzYellow)
        .sensoryFeedback(.impact, trigger: trigger)
        .withTrigger(trigger: $trigger) {
            onNavigationPressed?()
        }
    }
}

#Preview {
    GameRulesNavigationLink()
        .padding()
}
