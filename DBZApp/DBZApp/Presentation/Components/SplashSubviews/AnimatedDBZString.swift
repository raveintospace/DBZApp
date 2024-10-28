//
//  AnimatedDBZString.swift
//  DBZApp
//
//  Created by Uri on 26/10/24.
//

import SwiftUI

struct AnimatedDBZString: View {
    
    let text: String
    @Binding var isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(text.enumerated()), id: \.offset) { index, letter in
                Text(String(letter))
                    .font(.system(size: 40, weight: .heavy, design: .serif))
                    .foregroundStyle(.dbzYellow)
                    .shadow(color: .dbzOrange, radius: 1, x: 0, y: 0)
                    .shadow(color: .dbzOrange, radius: 2, x: 0, y: 0)
                    .rotation3DEffect(
                        .degrees(isAnimating ? 360 : 0),
                        axis: (x: 1, y: 0, z: 0))
                    .animation(.spring(duration: 1.5)
                        .delay(Double(index) * 0.05), value: isAnimating)
            }
        }
        .padding(.horizontal)
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    AnimatedDBZString(text: "Created by URI46", isAnimating: .constant(true))
}
