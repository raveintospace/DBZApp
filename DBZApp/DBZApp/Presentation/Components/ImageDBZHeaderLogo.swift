//
//  ImageHeaderLogo.swift
//  DBZApp
//
//  Created by Uri on 26/10/24.
//

import SwiftUI

struct ImageDBZHeaderLogo: View {
    
    @State private var animationOffset: CGFloat = -1.0
    var hasReflectionEffect: Bool = false
    
    var body: some View {
        ZStack {
            Image("headerLogo")
                .resizable()
                .scaledToFit()
                .overlay(
                    hasReflectionEffect ?
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, Color.white.opacity(0.3), .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .offset(x: animationOffset * UIScreen.main.bounds.width)
                    .mask(
                        Image("headerLogo")
                            .resizable()
                            .scaledToFit()
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(
                                .linear(duration: 1.5)
                            ) {
                                animationOffset = 1.0
                            }
                        }
                    }
                    : nil
                )
        }
    }
}

#Preview {
    ImageDBZHeaderLogo(hasReflectionEffect: true)
}
