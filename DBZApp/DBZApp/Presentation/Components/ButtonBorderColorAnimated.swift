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
    
    var buttonText: String = "Swift UIButton"
    var onButtonPressed: (() -> Void)? = nil
    var myGradient: Gradient = Gradient(colors: [.dbzYellow, .dbzOrange, .dbzBlue])
    var duration: Double = 1.5
    var width: CGFloat = 200
    var gradientHeight: CGFloat = 43
    var buttonHeight: CGFloat = 40
    var cornerRadius: CGFloat = 20
    var radius: CGFloat = 1
    var buttonFontSize: CGFloat = 20
    var buttonFontWeight: Font.Weight = .bold
    
    @State private var trigger = false
    
    var body: some View {
        Button(buttonText) {
            trigger.toggle()
        }
        .font(.system(size: buttonFontSize, weight: buttonFontWeight))
        .foregroundStyle(.accent)
        .frame(width: width, height: buttonHeight)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    LinearGradient(
                        gradient: myGradient,
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
        ButtonBorderColorAnimated(buttonText: "Planet")
        ButtonBorderColorAnimated(buttonText: "Transformations")
    }
}
