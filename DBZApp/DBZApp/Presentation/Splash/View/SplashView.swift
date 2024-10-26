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
    }
}

#Preview {
    SplashView()
}

extension SplashView {
    
    private var splashHeaderLogo: some View {
        ImageHeaderLogo()
            .frame(alignment: .top)
    }
    
    private var splashDragonBall: some View {
        AnimatedDragonBall(waveOffset: $waveOffset, progress: $progress)
    }
    
    private var splashAnimatedDBZString: some View {
        AnimatedDBZString(text: creatorText, isAnimating: $isTextAnimating)
    }
}
