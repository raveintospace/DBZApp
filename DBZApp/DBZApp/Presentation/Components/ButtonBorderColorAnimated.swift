//
//  ButtonBorderColorAnimated.swift
//  DBZApp
//
//  Created by Uri on 12/10/24.
//

import SwiftUI
import SwiftfulUI

struct ButtonBorderColorAnimated: View {
    
    @State private var isAnimating: Bool = false
    
    var text: String = "Text Border Color Animated"
    var onButtonPressed: (() -> Void)? = nil
    var buttonGradient: Gradient = Gradient(colors: [.dbzYellow, .dbzOrange, .dbzBlue])
    var duration: Double = 1.5
    var width: CGFloat = 200
    var gradientHeight: CGFloat = 43
    var buttonHeight: CGFloat = 40
    var cornerRadius: CGFloat = 20
    var radius: CGFloat = 1
    var fontName: String? = nil
    var fontSize: CGFloat = 20
    var fontWeight: Font.Weight = .bold
    
    @State private var trigger = false
    
    var body: some View {
        Text(text)
            .font(
                fontName != nil ?
                    .custom(fontName!, size: fontSize).weight(fontWeight) : .system(size: fontSize, weight: fontWeight)
            )
            .foregroundStyle(.accent)
            .frame(width: width, height: buttonHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            gradient: buttonGradient,
                            startPoint: isAnimating ? .topTrailing : .bottomLeading,
                            endPoint: isAnimating ? .bottomTrailing : .center
                        ),
                        lineWidth: 4
                    )
                    .blur(radius: radius)
                    .animation(.easeInOut(duration: duration).repeatForever(autoreverses: true), value: isAnimating)
            )
            .onAppear {
                isAnimating = true
            }
            .sensoryFeedback(.impact, trigger: trigger)
            .withTrigger(trigger: $trigger) {
                onButtonPressed?()
            }
    }
}

#Preview {
    VStack(spacing: 20) {
        ButtonBorderColorAnimated(text: "Planet")
        ButtonBorderColorAnimated(text: "Transformations")
        ButtonBorderColorAnimated(text: "Home", buttonHeight: 70, fontName: "SaiyanSans", fontSize: 50)
        ButtonBorderColorAnimated(text: "App Info", buttonHeight: 70, fontName: "SaiyanSans", fontSize: 50)
    }
}
