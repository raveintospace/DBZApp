//
//  CardPositionModifier.swift
//  DBZApp
//  Gets global position of each card on the view where it is used and store it
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
