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
        ImageLoaderView(url: imageName, allowHitTesting: true)
            .beZoomable()
    }
}

#Preview {
    PlanetImageCell()
}
