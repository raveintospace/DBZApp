//
//  DetailBottomButtons.swift
//  DBZApp
//
//  Created by Uri on 5/10/24.
//

import SwiftUI

struct DetailBottomButtons: View {
    
    var showTransformationsButton: Bool = false
    var onPlanetButtonPressed: () -> Void
    var onTransformationButtonPressed: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            TextBorderColorAnimated(
                text: "Planet",
                onTextPressed: onPlanetButtonPressed
            )
            TextBorderColorAnimated(
                text: "Transformations",
                onTextPressed: onTransformationButtonPressed
            )
                .opacity(showTransformationsButton ? 1 : 0)
        }
    }
}

#Preview {
    DetailBottomButtons(showTransformationsButton: true, onPlanetButtonPressed: {}, onTransformationButtonPressed: {})
}
