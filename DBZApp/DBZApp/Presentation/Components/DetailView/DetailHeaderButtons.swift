//
//  DetailHeaderButtons.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI

struct DetailHeaderButtons: View {
    
    var isFavorite: Bool = false
    var onBackButtonPressed: (() -> Void)? = nil
    var onFavButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    var triggerDelay: Double = 0.3
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircleButton(imageName: "arrowshape.backward")
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    onBackButtonPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageOrangeCircleButton(
                imageName: isFavorite ? "star.fill" : "star",
                frameSize: 40,
                fontSize: 20
            )
                .opacity(isFavorite ? 1 : 0.5)
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    
                    onFavButtonPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ZStack {
        Image("kingkaiWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)

        DetailHeaderButtons()
    }
}
