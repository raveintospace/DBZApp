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
            
            VStack {
                header
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        basicConceptsText
                        DBZDivider()
                        scoringText
                        DBZDivider()
                        discardingText
                    }
                }
                .foregroundStyle(.dbzYellow)
                .scrollIndicators(.hidden)
                .clipped()
            }
        }
    }
}

#Preview {
    RouterView { _ in
        GameRulesView()
    }
}

extension GameRulesView {
    private var header: some View {
        HStack(spacing: 0) {
            headerButton
            headerTitle
            hiddenButton
        }
        .foregroundStyle(.dbzYellow)
    }
    
    private var headerButton: some View {
        Image(systemName: "arrowshape.down.fill")
            .font(.title2)
            .padding(8)
            .background(
                Circle()
                    .stroke(lineWidth: 1))
            .sensoryFeedback(.impact, trigger: trigger)
            .withTrigger(trigger: $trigger) {
                router.dismissScreen()
            }
            .frame(alignment: .leading)
            .padding()
    }
    
    private var headerTitle: some View {
        Text("GAME RULES")
            .font(.title2)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var hiddenButton: some View {
        ImageBlueCircle(imageName: "house.fill")
            .hidden()
            .frame(alignment: .trailing)
            .padding()
    }
    
    private var basicConceptsText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("BASIC CONCEPTS:")
                .font(.title3)
                .bold()
            Text("· The match follows the logic of tennis scoring: Game - Set - Match.")
            Text("· The match winner is the first player to achieve the required number of sets to win.")
            Text("· A set is won by the first player to achieve the necessary number of games.")
            Text("· A game is won by the player with the highest hand points at the end of the turn.")
        }
        .padding(.horizontal)
    }
    
    private var scoringText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SCORING:")
                .font(.title3)
                .bold()
            Text("· The hand points are the total points of the three cards in the player's hand.")
            Text("· Jokers (characters with unknown ki points, highlighted in green) multiply the rest of the hand's points by 1.5.")
            Text("· Three Jokers result in a score of 0 points, as there are no base points to multiply.")
            Text("· The only Malus card in the deck (highlighted in red) halves the player's total points.")
        }
        .padding(.horizontal)
    }
    
    private var discardingText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("DISCARDING CARDS:")
                .font(.title3)
                .bold()
            Text("· You may discard cards (partially or completely) up to two times per turn. Your rival can't discard cards.")
            Text("· Discarded cards return to the deck and may appear again.")
            Text("· The discard counter indicates the remaining discard rounds available for the turn.")
        }
        .padding(.horizontal)
    }
}
