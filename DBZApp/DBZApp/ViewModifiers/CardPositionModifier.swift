//
//  CardPositionModifier.swift
//  DBZApp
//
//  Created by Uri on 15/12/24.
//

import SwiftUI

struct CardPositionModifier: ViewModifier {
    let index: Int
    @Binding var positions: [CGRect]
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear.onAppear {
                        DispatchQueue.main.async {
                            positions[index] = geometry.frame(in: .global)
                        }
                    }
                }
            )
    }
}
