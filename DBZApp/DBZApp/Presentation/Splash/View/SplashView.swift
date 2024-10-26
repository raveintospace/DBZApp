//
//  SplashView.swift
//  DBZApp
//
//  Created by Uri on 26/10/24.
//

import SwiftUI

struct SplashView: View {
    
    @State private var waveOffset: Angle = .zero
    @State private var progress: Double = 0
    @State private var xOffset: CGFloat = .zero
    
    var body: some View {
        ZStack {
            Color.dbzYellow.ignoresSafeArea()
            
            VStack {
                headerLogo
                animatedDragonBall
                headerLogo
            }
        }
    }
}

#Preview {
    SplashView()
}

extension SplashView {
    
    private var headerLogo: some View {
        Image("headerLogo")
            .resizable()
            .scaledToFit()
            .frame(alignment: .top)
    }
    
    private var animatedDragonBall: some View {
        ZStack {
            Circle()
                .fill(.dbzOrange.opacity(0.6))
            
            WaveShape(offset: waveOffset, percent: progress, xOffset: 0)
                .fill(.dbzOrange.opacity(0.8))
                .clipShape(Circle())
            
            WaveShape(offset: waveOffset + .degrees(60), percent: progress, xOffset: 0.7)
                .fill(.dbzOrange.opacity(0.8))
                .clipShape(Circle())
            
            Image(systemName: "star.fill")
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.dbzBlue)
        }
        .padding(.horizontal, 30)
        .frame(maxHeight: .infinity, alignment: .center)
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                waveOffset = .init(degrees: 360)
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                if progress >= 1.0 {
                    timer.invalidate()
                } else {
                    progress += 0.01
                }
            }
        }
    }
}
