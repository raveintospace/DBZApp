//
//  CardFlip.swift
//  DBZApp
//
//  Created by Uri on 30/11/24.
//

import SwiftUI

struct CardFlip<Front: View, Back: View>: ViewModifier, Animatable {
    
    var rotation: Double
    let front: Front
    let back: Back
    
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
                    .scaleEffect(x: -1, y: 1)
            }
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.5), value: rotation)
    }
}

extension View {
    func cardFlip<Front: View, Back: View>(isRevealed: Bool, front: () -> Front, back: () -> Back) -> some View {
        modifier(CardFlip(isRevealed: isRevealed, front: front(), back: back()))
    }
}
