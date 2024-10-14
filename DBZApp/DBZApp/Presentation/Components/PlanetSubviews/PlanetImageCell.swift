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
    @State private var pan: CGSize = .zero
    
    // Estado para mantener la escala y el desplazamiento en el gesto
    @GestureState private var gestureScale: CGFloat = 1.0
    @GestureState private var gesturePan: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            
            // Carga de la imagen con el gesto de escala y movimiento
            ImageLoaderView(url: imageName)
                .scaledToFit()
                .scaleEffect(scale * gestureScale) // Aplicamos la escala acumulada
                .offset(x: pan.width + gesturePan.width, y: pan.height + gesturePan.height) // Aplicamos el desplazamiento
                .gesture(
                    // Gesto combinado: zoom y pan
                    panGesture.simultaneously(with: zoomGesture)
                )
                .animation(.easeInOut, value: scale) // Animación para la transición suave
        }
    }
    
    // Gesto de zoom (magnificación)
    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($gestureScale) { value, gestureScale, _ in
                gestureScale = value
            }
            .onEnded { value in
                scale *= value // Aplica el factor final al zoom
            }
    }
    
    // Gesto de pan (desplazamiento)
    private var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { value, gesturePan, _ in
                gesturePan = value.translation
            }
            .onEnded { value in
                pan.width += value.translation.width
                pan.height += value.translation.height
            }
    }
}

#Preview {
    PlanetImageCell()
}
