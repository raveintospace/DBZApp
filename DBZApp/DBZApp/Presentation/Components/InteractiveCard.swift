//
//  InteractiveCard.swift
//  DBZApp
//
//  Created by Uri on 5/10/24.
//

import SwiftUI
import SwiftfulUI

struct InteractiveCard: View {
    
    var cardText: String = ""
    var cardIcon: String = ""
    var onCardPressed: (() -> Void)? = nil
    
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging: Bool = false
    @State private var rotation: Double = 0
    
    @State private var trigger = false
    private let triggerDelay: Double = 0.3
    
    var body: some View {
        ZStack {
            HStack {
                Text(cardText)
                Text(cardIcon)
            }
            .font(.callout)
            .fontWeight(.bold)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .foregroundStyle(.dbzBlue.gradient)
            .background(LinearGradient(gradient: .init(colors: [.dbzYellow, .dbzOrange]), startPoint: .leading, endPoint: .trailing))
            .clipShape(.rect(cornerRadius: 32))
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.dbzBlue.opacity(0.3), lineWidth: 2))
            .shadow(color: .dbzYellow.opacity(0.75), radius: 5)
            .rotation3DEffect(
                .init(degrees: rotation + Double(dragOffset.width) / 10),
                axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(
                .init(degrees: rotation + Double(dragOffset.height) / 10),
                axis: (x: 1, y: 0, z: 0))
        }
        .gesture(DragGesture().onChanged { value in
            isDragging = true
            dragOffset = value.translation
        }
            .onEnded { _ in
                isDragging = false
                withAnimation(.spring) { dragOffset = .zero }
            })
        .animation(isDragging ? .none : .spring(), value: dragOffset)
        .sensoryFeedback(.impact, trigger: trigger)
        
        .asButton(.press) {
            trigger = true
            withAnimation {
                onCardPressed?()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                trigger = false
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                rotation = -15
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1)) {
                    rotation = 0
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        InteractiveCard(cardText: "Planets", cardIcon: "🪐")
        InteractiveCard(cardText: "Transformations", cardIcon: "🦹🏼‍♂️")
        
    }
}
