//
//  GameActionButton.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameActionButton: View {
    
    var imageName: String = ""
    var linewidth: CGFloat = 3
    var width: CGFloat = 60
    var imageYOffset: CGFloat = 0
    var isEnabled: Bool = true
    var onButtonPressed: (() -> Void)? = nil
    
    @State private var trigger: Bool = false
    
    var body: some View {
        Circle()
            .fill(.dbzBlue)
            .stroke(.dbzOrange, lineWidth: linewidth)
            .frame(width: width)
            .overlay {
                Image(systemName: imageName)
                    .font(.title)
                    .offset(y: imageYOffset)
                    .foregroundStyle(.dbzYellow)
            }
            .sensoryFeedback(.impact, trigger: trigger)
            .withTrigger(trigger: $trigger) {
                if isEnabled {
                    onButtonPressed?()
                }
            }
            .opacity(isEnabled ? 1.0 : 0.5)
            .disabled(!isEnabled)
    }
}

#Preview {
    VStack(spacing: 8) {
        GameActionButton(imageName: "play.fill", isEnabled: false)
        GameActionButton(imageName: "arrow.2.circlepath")
        GameActionButton(imageName: "play.rectangle.on.rectangle")
        GameActionButton(imageName: "play.rectangle")
        GameActionButton(imageName: "tray.and.arrow.down", imageYOffset: -2)
        GameActionButton(imageName: "checkmark")
        GameActionButton(imageName: "xmark")
    }
}


