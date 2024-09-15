//
//  ImageLoader.swift
//  DBZApp
//
//  Created by Uri on 15/9/24.
//

import SwiftUI

// Generic image loader, no need to import Kingfisher
// We can add several SDKs with this struct (if SDWeb... else Kingfisher)

struct ImageLoaderView: View {
    
    let url: String
    var contentMode: ContentMode = .fit
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                KingfisherImageLoader(url: url, contentMode: contentMode)
                    .allowsHitTesting(false)
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView(url: "https://dragonball-api.com/characters/vegeta_normal.webp")
    .background(.red)
    .clipShape(.rect(cornerRadius: 30))
    .padding(20)
    .padding(.vertical, 30)
}

// fit: image without cuts, whole image with original proportions
// fill: image may be cut, adapts to frame, loses original proportions

// Rectangle controls the frame and image adapts to it with the overlay
// If we don't use rectangle, with the same frame (200*200), image occupies more space than rectangle, because it is higher (200*300)
// Clipped puts the image inside the rectangle
// .allowsHitTesting(false) - only rectangle frame is clickable
