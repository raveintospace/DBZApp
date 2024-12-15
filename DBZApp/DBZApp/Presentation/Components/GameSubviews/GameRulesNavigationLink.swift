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
        Button(action: {
            trigger = true
            onNavigationPressed?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                trigger = false
            }
        }) {
            HStack {
                Text("Game rules")
                Spacer()
                Image(systemName: "book.pages")
            }
            .font(.title2)
            .bold()
            .foregroundStyle(.dbzYellow)
            .sensoryFeedback(.impact, trigger: trigger)
        }
    }
}

#Preview {
    GameRulesNavigationLink()
        .padding()
}

// Not using withTrigger to avoid the HStack being compressed with on tap gesture
