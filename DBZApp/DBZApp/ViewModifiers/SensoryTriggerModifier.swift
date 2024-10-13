//
//  SensoryTriggerModifier.swift
//  DBZApp
//
//  Created by Uri on 13/10/24.
//

import SwiftUI
import SwiftfulUI

struct SensoryTriggerModifier: ViewModifier {
    @Binding var trigger: Bool
    var delay: Double = 0.3
    var onPress: () -> Void
    
    func body(content: Content) -> some View {
        content
            .asButton(.press) {
                trigger = true
                onPress()
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    trigger = false
                }
            }
    }
}

extension View {
    func withTrigger(trigger: Binding<Bool>, delay: Double = 0.3, onPress: @escaping () -> Void) -> some View {
        self.modifier(SensoryTriggerModifier(trigger: trigger, delay: delay, onPress: onPress))
    }
}

