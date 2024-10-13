//
//  ButtonBorderColorAnimated.swift
//  DBZApp
//
//  Created by Uri on 12/10/24.
//

import SwiftUI
import SwiftfulUI

struct TextBorderColorAnimated: View {
    
    @State private var isAnimating: Bool = false
    
    var text: String = "Text Border Color Animated"
    var onTextPressed: (() -> Void)? = nil
    var myGradient: Gradient = Gradient(colors: [.dbzYellow, .dbzOrange, .dbzBlue])
    var duration: Double = 1.5
    var width: CGFloat = 200
    var gradientHeight: CGFloat = 43
    var buttonHeight: CGFloat = 40
    var cornerRadius: CGFloat = 20
    var radius: CGFloat = 1
    var FontSize: CGFloat = 20
    var FontWeight: Font.Weight = .bold
    
    @State private var trigger = false
    
    var body: some View {
        Text(text)
            .font(.system(size: FontSize, weight: FontWeight))
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
                onTextPressed?()
            }
    }
}

#Preview {
    VStack(spacing: 20) {
        TextBorderColorAnimated(text: "Planet")
        TextBorderColorAnimated(text: "Transformations")
    }
}
