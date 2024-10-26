//
//  AnimatedDragonBall.swift
//  DBZApp
//
//  Created by Uri on 26/10/24.
//

import SwiftUI

struct AnimatedDragonBall: View {
    @Binding var waveOffset: Angle
    @Binding var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.dbzYellow)

            WaveShape(offset: waveOffset, percent: progress, xOffset: 0)
                .fill(Color.dbzOrange.opacity(0.6))
                .clipShape(Circle())

            WaveShape(offset: waveOffset + .degrees(60), percent: progress, xOffset: 0.7)
                .fill(Color.dbzOrange.opacity(0.8))
                .clipShape(Circle())

            Image(systemName: "star.fill")
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(Color.dbzBlue)
        }
        .padding(.horizontal, 30)
        .frame(maxHeight: .infinity, alignment: .center)
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                waveOffset = .init(degrees: 360)
            }

            Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { timer in
                if progress >= 1.0 {
                    timer.invalidate()
                } else {
                    progress += 0.0125
                }
            }
        }
    }
}

#Preview {
    AnimatedDragonBall(waveOffset: .constant(.zero), progress: .constant(0.64))
}
