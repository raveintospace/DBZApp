//
//  Zoomable.swift
//  DBZApp
//  Enables zoom & pan to any view
//  Created by Uri on 18/10/24.
//

import SwiftUI

struct ZoomableModifier: ViewModifier {
    
    @State private var lastTransform: CGAffineTransform = .identity
    @State private var transform: CGAffineTransform = .identity
    @State private var contentSize: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .background(alignment: .topLeading) {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            contentSize = proxy.size
                        }
                }
            }
            .animatableTransformEffect(transform)
            .gesture(magnificationGesture)
            .gesture(dragGesture)
    }
    
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let zoomScale = max(value, 1.0)
                
                let anchorPoint = CGPoint(x: contentSize.width / 2, y: contentSize.height / 2)
                let newTransform = CGAffineTransform.anchoredScale(
                    scale: zoomScale,
                    anchor: anchorPoint
                )
                transform = lastTransform.concatenating(newTransform)
            }
            .onEnded { _ in
                withAnimation(.easeInOut) {
                    transform = .identity
                    lastTransform = .identity
                }
            }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                transform = lastTransform.translatedBy(
                    x: value.translation.width / transform.scaleX,
                    y: value.translation.height / transform.scaleY
                )
            }
            .onEnded { _ in
                lastTransform = transform
            }
    }
}

public extension View {
    func zoomable() -> some View {
        modifier(ZoomableModifier())
    }
}

private extension View {
    @ViewBuilder
    func animatableTransformEffect(_ transform: CGAffineTransform) -> some View {
        scaleEffect(
            x: transform.scaleX,
            y: transform.scaleY,
            anchor: .center
        )
        .offset(x: transform.tx, y: transform.ty)
    }
}

private extension CGAffineTransform {
    static func anchoredScale(scale: CGFloat, anchor: CGPoint) -> CGAffineTransform {
        CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: -anchor.x, y: -anchor.y)
    }
    
    var scaleX: CGFloat {
        sqrt(a * a + c * c)
    }
    
    var scaleY: CGFloat {
        sqrt(b * b + d * d)
    }
}
