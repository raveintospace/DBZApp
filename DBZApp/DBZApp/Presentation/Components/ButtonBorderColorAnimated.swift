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
    var radius: CGFloat = 4
    var buttonFontSize: CGFloat = 20
    var buttonFontWeight: Font.Weight = .bold
    
    @State private var trigger = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: myGradient,
                           startPoint: isAnimating ? .topTrailing : .bottomLeading,
                           endPoint: isAnimating ? .bottomTrailing : .center)
            .animation(.easeInOut(duration: duration)
                .repeatForever(autoreverses: true), value: isAnimating)
            .frame(width: width, height: gradientHeight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .blur(radius: radius)
            
            Button(buttonText) { }
                .font(.system(size: buttonFontSize, weight: buttonFontWeight))
                .foregroundStyle(.accent)
                .frame(width: width, height: buttonHeight)
                .background(.own)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .onAppear {
            isAnimating.toggle()
        }
        .sensoryFeedback(.impact, trigger: trigger)
        .withTrigger(trigger: $trigger) {
            onButtonPressed?()
        }
    }
}

#Preview {
    VStack {
        ButtonBorderColorAnimated(buttonText: "Planet")
        ButtonBorderColorAnimated(buttonText: "Transformations")
    }
}
