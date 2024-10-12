//
//  DetailHeaderButtons.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI

struct DetailHeaderBar: View {
    
    var headerTitle: String = ""
    var showHeaderTitle: Bool = false
    var isFavorite: Bool = false
    var onBackButtonPressed: (() -> Void)? = nil
    var onFavButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    private let triggerDelay: Double = 0.3
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "arrowshape.backward.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    onBackButtonPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(width: 50, alignment: .leading)
            
            Text(headerTitle.uppercased())
                .lineLimit(1)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity)
                .opacity(showHeaderTitle ? 1 : 0)
            
            ImageOrangeCircle(
                imageName: isFavorite ? "star.fill" : "star",
                frameSize: 40,
                fontSize: 20
            )
                .opacity(isFavorite ? 1 : 0.5)
                .rotationEffect(Angle(degrees: isFavorite ? -72 : 0))
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    
                    onFavButtonPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(width: 50, alignment: .trailing)
        }
    }
}

#Preview {
    ZStack {
        Image("kingkaiWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)

        DetailHeaderBar(headerTitle: "fdsafadsafdsafdaffadfa", showHeaderTitle: true)
    }
}
