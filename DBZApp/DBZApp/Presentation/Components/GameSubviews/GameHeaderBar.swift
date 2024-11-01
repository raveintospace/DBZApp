//
//  GameHeaderBar.swift
//  DBZApp
//
//  Created by Uri on 1/11/24.
//

import SwiftUI

struct GameHeaderBar: View {
    
    var onHomeButtonPressed: (() -> Void)? = nil
    var onSettingsButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "house.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onHomeButtonPressed?()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageDBZHeaderLogo()
                .frame(maxWidth: .infinity, alignment: .center)
            
            ImageBlueCircle(imageName: "gearshape.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onSettingsButtonPressed?()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    GameHeaderBar()
        .padding(.horizontal)
}
