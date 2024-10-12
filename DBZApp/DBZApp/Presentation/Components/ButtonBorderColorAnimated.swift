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
    
    private let myGradient: Gradient = Gradient(colors: [.dbzYellow, .dbzOrange, .dbzBlue])
    
    @State private var trigger = false
    var triggerDelay: Double = 0.3
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: myGradient,
                           startPoint: isAnimating ? .topTrailing : .bottomLeading,
                           endPoint: isAnimating ? .bottomTrailing : .center)
            .animation(.easeInOut(duration: 1)
                .repeatForever(autoreverses: true), value: isAnimating)
            .frame(width: 200, height: 43)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .blur(radius: 4)
            
            Button(buttonText) { }
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.accent)
                .frame(width: 200, height: 40)
                .background(.own)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .onAppear {
            isAnimating.toggle()
        }
        .asButton(.press) {
            trigger = true
            onButtonPressed?()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                trigger = false
            }
        }
    }
}

#Preview {
    VStack {
        ButtonBorderColorAnimated(buttonText: "Planet")
        ButtonBorderColorAnimated(buttonText: "Transformations")
    }
}
