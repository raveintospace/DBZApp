//
//  PlanetImageCell.swift
//  DBZApp
//
//  Created by Uri on 14/10/24.
//

import SwiftUI

struct PlanetImageCell: View {
    
    var imageName: String = DetailedCharacter.mock.originPlanet.image
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(url: imageName, allowHitTesting: true)
                    .scaleEffect(scale)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            if value.magnitude < 1.0 {
                                scale = 1.0
                            } else {
                                scale = value.magnitude
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.easeInOut) {
                                scale = 1.0
                                
                            }
                        }
                    )
            )
    }
}

#Preview {
    PlanetImageCell()
}
