//
//  PlanetHeaderBar.swift
//  DBZApp
//
//  Created by Uri on 21/10/24.
//

import SwiftUI

struct PlanetHeaderBar: View {
    var headerTitle: String = ""
    var showPlanetModal: Bool = false
    var onBackButtonPressed: (() -> Void)? = nil
    var onFavButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "arrowshape.backward.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onBackButtonPressed?()
                }
                .frame(width: 50, alignment: .leading)
            
            Text(headerTitle.uppercased())
                .lineLimit(1)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity)
            
            ImageBlueCircle(imageName: showPlanetModal ? "info.circle.fill" : "info.circle")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onFavButtonPressed?()
                }
                .frame(width: 50, alignment: .trailing)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PlanetHeaderBar(showPlanetModal: true)
        PlanetHeaderBar(showPlanetModal: false)
    }
}
