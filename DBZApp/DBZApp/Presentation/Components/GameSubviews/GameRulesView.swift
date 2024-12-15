//
//  GameRulesView.swift
//  DBZApp
//
//  Created by Uri on 15/12/24.
//

import SwiftUI
import SwiftfulRouting

struct GameRulesView: View {
    
    @Environment(\.router) private var router
    @State private var trigger = false
    
    var body: some View {
        ZStack {
            Color.dbzBlue.ignoresSafeArea()
            
            headerButton
            
            Text("This is the rules view")
        }
    }
}

#Preview {
    RouterView { _ in
        GameRulesView()
    }
}

extension GameRulesView {
    private var headerButton: some View {
        Image(systemName: "arrowshape.down.fill")
            .font(.title2)
            .padding(8)
            .background(
                Circle()
                    .stroke(lineWidth: 1))
            .foregroundStyle(.dbzYellow)
            .sensoryFeedback(.impact, trigger: trigger)
            .withTrigger(trigger: $trigger) {
                router.dismissScreen()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}
