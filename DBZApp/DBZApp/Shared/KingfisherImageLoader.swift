//
//  KingfisherImageLoader.swift
//  DBZApp
//
//  Created by Uri on 15/9/24.
//

import SwiftUI
import Kingfisher

struct KingfisherImageLoader: View {
    
    let url: String
    var contentMode: SwiftUI.ContentMode = .fill
    
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                Image("traced-sevenDragonBalls")
                    .resizable()
            }
            .resizable()
            .onProgress({ receivedSize, totalSize in
                
            })
            .onSuccess({ result in
                
            })
            .onFailure({ error in
                
            })
            .aspectRatio(contentMode: contentMode)
    }
}

#Preview {
    KingfisherImageLoader(
        url: "https://dragonball-api.com/characters/goku_normal.webp",
        contentMode: .fit
    )
    .background(.green)
    .frame(width: 200, height: 200)
    .background(.blue)
}
