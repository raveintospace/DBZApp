//
//  CardFlip.swift
//  DBZApp
//
//  Created by Uri on 30/11/24.
//

import SwiftUI

struct CardFlipModifier<Front: View, Back: View>: ViewModifier, Animatable {
    
    let front: Front
    let back: Back
    var rotation: Double
    
    var isRevealed: Bool {
        rotation < 90
    }
    
    // custom rotation
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isRevealed: Bool, front: Front, back: Back) {
        self.front = front
        self.back = back
        self.rotation = isRevealed ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isRevealed {
                front
            } else {
                back
                    .scaleEffect(x: -1, y: 1)       // avoids mirror effect
            }
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.3), value: rotation)
    }
}

extension View {
    func cardFlipModifier<Front: View, Back: View>(isRevealed: Bool, front: () -> Front, back: () -> Back) -> some View {
        modifier(CardFlipModifier(isRevealed: isRevealed, front: front(), back: back()))
    }
}
