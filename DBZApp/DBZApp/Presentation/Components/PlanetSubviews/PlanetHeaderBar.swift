//
//  PlanetHeaderBar.swift
//  DBZApp
//
//  Created by Uri on 21/10/24.
//

import SwiftUI

struct PlanetHeaderBar: View {
    var headerTitle: String = ""
    var onBackButtonPressed: (() -> Void)? = nil
    var onInfoButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "arrowshape.down.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onBackButtonPressed?()
                }
                .frame(width: 50, alignment: .leading)
            
            Text(headerTitle.uppercased())
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
            
            ImageBlueCircle(imageName: "info")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onInfoButtonPressed?()
                }
                .frame(width: 50, alignment: .trailing)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PlanetHeaderBar(headerTitle: "North Kai")
        PlanetHeaderBar(headerTitle: "Zeno's Moving Temple")
            .padding(.horizontal)
    }
}
