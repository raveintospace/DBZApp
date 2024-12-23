//
//  DetailHeaderButtons.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI

struct DetailHeaderBar: View {
    
    var headerTitle: String = ""
    var url: String = "https://www.apple.com"
    var showHeaderTitle: Bool = false
    var isFavorite: Bool = false
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
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                .opacity(showHeaderTitle ? 1 : 0)
            
            HStack(spacing: 6) {
                ImageOrangeCircle(
                    imageName: isFavorite ? "star.fill" : "star",
                    frameSize: 45,
                    fontSize: 25
                )
                .opacity(isFavorite ? 1 : 0.5)
                .rotationEffect(Angle(degrees: isFavorite ? -72 : 0))
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onFavButtonPressed?()
                }
                DetailShareButton(url: url)
            }
            .frame(alignment: .trailing)
        }
    }
}

#Preview {
    DetailHeaderBar(headerTitle: "fdsafadsafdsafdaffadfa", showHeaderTitle: true)
        .padding()
}
