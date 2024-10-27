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
    
    @State private var isTextAnimating: Bool = false
    private let creatorText: String = "Created by Uri46"
    
    @Binding var showSplashView: Bool
    
    var body: some View {
        ZStack {
            Color.dbzBlue.ignoresSafeArea()
            
            VStack {
                splashHeaderLogo
                splashDragonBall
                splashAnimatedDBZString
            }
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                withAnimation(.easeOut(duration: 0.3)) {
                    showSplashView = false
                }
            }
        }
    }
}

#Preview {
    SplashView(showSplashView: .constant(true))
}

extension SplashView {
    
    private var splashHeaderLogo: some View {
        ImageDBZHeaderLogo()
            .frame(alignment: .top)
    }
    
    private var splashDragonBall: some View {
        AnimatedDragonBall(waveOffset: $waveOffset, progress: $progress)
    }
    
    private var splashAnimatedDBZString: some View {
        AnimatedDBZString(text: creatorText, isAnimating: $isTextAnimating)
    }
}
