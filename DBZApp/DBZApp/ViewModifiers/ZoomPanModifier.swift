//
//  ZoomPanModifier.swift
//  DBZApp
//  Enables zoom to any view and then pan it
//  Created by Uri on 28/12/24.
//

#if os(iOS)

import SwiftUI

import SwiftUI

struct ZoomPanModifier: ViewModifier {
    @State private var currentScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @GestureState private var gestureScale: CGFloat = 1.0
    @GestureState private var gestureOffset: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(currentScale * gestureScale)
            .offset(x: offset.width + gestureOffset.width, y: offset.height + gestureOffset.height)
            .gesture(
                SimultaneousGesture(
                    MagnifyGesture()
                        .updating($gestureScale) { value, state, _ in
                            state = value.magnification
                        }
                        .onEnded { value in
                            currentScale *= value.magnification
                            // Ensure the scale doesn't go below 1
                            if currentScale < 1 {
                                currentScale = 1
                                offset = .zero
                            }
                        },
                    DragGesture()
                        .updating($gestureOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            offset.width += value.translation.width
                            offset.height += value.translation.height
                        }
                )
            )
    }
}

extension View {
    func zoomAndPanModifier() -> some View {
        self.modifier(ZoomPanModifier())
    }
}

#endif
