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
    
    // 0 - 90 = front / 91 - 180 = back
    var isRevealed: Bool {
        rotation < 90
    }
    
    // animate rotation using interpolation
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isRevealed: Bool, front: Front, back: Back) {
        self.rotation = isRevealed ? 0 : 180
        self.front = front
        self.back = back
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isRevealed {
                front
            } else {
                back
                    .scaleEffect(x: -1, y: 1)       // avoids mirror effect caused by rotation3DEffect
            }
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.4), value: rotation)
    }
}

extension View {
    func cardFlipModifier<Front: View, Back: View>(isRevealed: Bool, front: () -> Front, back: () -> Back) -> some View {
        modifier(CardFlipModifier(isRevealed: isRevealed, front: front(), back: back()))
    }
}
