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
            .scaleEffect(max(1.0, currentScale * gestureScale)) // Ensure scale doesn't go below 1
            .offset(x: offset.width + gestureOffset.width, y: offset.height + gestureOffset.height)
            .gesture(
                SimultaneousGesture(
                    MagnifyGesture()
                        .updating($gestureScale) { value, state, _ in
                            state = value.magnification
                        }
                        .onEnded { value in
                            currentScale *= value.magnification
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
                            // Allow pan only if zoomed in
                            if currentScale > 1 {
                                offset.width += value.translation.width
                                offset.height += value.translation.height
                            } else {
                                offset = .zero
                            }
                        }
                )
            )
            .onTapGesture(count: 2) {
                // Reset zoom and pan on double tap
                withAnimation {
                    currentScale = 1.0
                    offset = .zero
                }
            }
    }
}

extension View {
    func zoomAndPanModifier() -> some View {
        self.modifier(ZoomPanModifier())
    }
}

#endif
