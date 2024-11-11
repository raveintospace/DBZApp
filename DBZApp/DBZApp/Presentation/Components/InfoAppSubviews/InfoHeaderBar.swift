//
//  InfoHeaderBar.swift
//  DBZApp
//
//  Created by Uri on 29/10/24.
//

import SwiftUI

struct InfoHeaderBar: View {
    
    var headerTitle: String = "App info"
    var onBackButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "house.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onBackButtonPressed?()
                }
                .frame(alignment: .leading)
                .padding(.trailing, 10)
            
            Text(headerTitle.uppercased())
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ImageBlueCircle(imageName: "house.fill")
                .hidden()
                .frame(alignment: .trailing)
        }
    }
}

#Preview {
    InfoHeaderBar()
}

/*
 func onBackButtonPressed(_ completion: @escaping () -> Void) -> Self {
     var copy = self
     copy.onBackButtonPressed = completion
     return copy
 }
 */
