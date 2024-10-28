//
//  ButtonAnimatedGlow.swift
//  DBZApp
//
//  Created by Uri on 28/10/24.
//

import SwiftUI

struct ButtonAnimatedGlow: View {
    
    @State private var glowAnimation: Bool = false
    
    var text: String = "Glowing Button"
    var onButtonPressed: (() -> Void)? = nil
    var buttonGradient: Gradient = Gradient(colors: [.dbzOrange, .dbzYellow, .dbzOrange])
    var duration: Double = 3
    var buttonWidth: CGFloat = 250
    var buttonHeight: CGFloat = 60
    var cornerRadius: CGFloat = 25
    var fontName: String? = "SaiyanSans"
    var fontSize: CGFloat = 40
    var fontWeight: Font.Weight = .bold
    
    @State private var trigger = false
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(glowAnimation ? .dbzBlue.opacity(0.75) : .dbzBlue)
                .frame(width: buttonWidth, height: buttonHeight)
                .animation(
                    .easeInOut(duration: duration / 2).repeatForever(autoreverses: true),
                    value: glowAnimation
                )
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    LinearGradient(
                        gradient: buttonGradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: glowAnimation ? 7 : 4)
                .frame(width: buttonWidth, height: buttonHeight)
                .animation(
                    .easeInOut(duration: duration / 2).repeatForever(autoreverses: true),
                    value: glowAnimation
                )
            
            Text(text)
                .font(fontName != nil ? .custom(fontName!, size: fontSize) : .system(size: fontSize, weight: fontWeight))
                .kerning(1.5)
                .baselineOffset(-5)
                .foregroundStyle(.dbzYellow)
                .shadow(color: .dbzOrange, radius: 1, x: 0, y: 0)
                .shadow(color: .dbzOrange, radius: 2, x: 0, y: 0)
        }
        .onAppear {
            glowAnimation = true
        }
        .sensoryFeedback(.impact, trigger: trigger)
        .withTrigger(trigger: $trigger) {
            onButtonPressed?()
        }
    }
}

#Preview {
    ZStack {
   //     Color.dbzBlue.ignoresSafeArea()
        
        VStack(spacing: 25) {
            ButtonAnimatedGlow(text: "Database")
            ButtonAnimatedGlow(text: "Game")
            ButtonAnimatedGlow(text: " App Info ")
        }
    }
}
