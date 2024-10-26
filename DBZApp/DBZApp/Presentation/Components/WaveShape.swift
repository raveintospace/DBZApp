//
//  WaveShape.swift
//  DBZApp
//
//  Created by Uri on 26/10/24.
//

import SwiftUI

struct WaveShape: Shape {
    var offset: Angle
    var percent: Double
    var xOffset: CGFloat
    
    var animatableData: AnimatablePair<Double, CGFloat> {
        get { AnimatableData(offset.degrees, xOffset) }
        set {
            offset = .degrees(newValue.first)
            xOffset = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            let midHeight = height * (1 - CGFloat(percent))
            let waveHeight = height * 0.05
            
            path.move(to: CGPoint(x: 0, y:  rect.maxY))
            
            for x in stride(from: 0, to: width, by: 2) {
                let relativeX = x / width
                let y = midHeight + sin((relativeX + xOffset) * Double.pi * offset.radians) * waveHeight
                path.addLine(to: CGPoint(x: x, y: y))
            }
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
