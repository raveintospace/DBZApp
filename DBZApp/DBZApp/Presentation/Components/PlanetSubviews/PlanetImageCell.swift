//
//  PlanetImageCell.swift
//  DBZApp
//
//  Created by Uri on 14/10/24.
//

import SwiftUI

struct PlanetImageCell: View {
    
    var imageName: String = DetailedCharacter.mock.originPlanet.image
    
    var body: some View {
        ImageLoaderView(url: imageName, allowHitTesting: true)
            .zoomAndPanModifier()
    }
}

#Preview {
    PlanetImageCell()
}

/*
 @GestureState private var zoom = 1.0
 
 .scaleEffect(zoom)
 .gesture(
     MagnifyGesture()
         .updating($zoom) { value, gestureState, transaction in
             gestureState = value.magnification
         }
 )
 */
