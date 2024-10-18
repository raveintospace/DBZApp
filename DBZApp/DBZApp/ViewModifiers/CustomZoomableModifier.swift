//
//  CustomZoomableModifier.swift
//  DBZApp
//  Enables zoom to any view, based on https://github.com/ryohey/Zoomable
//  Created by Uri on 18/10/24.
//

#if os(iOS)

import SwiftUI

struct CustomZoomableModifier: ViewModifier {
    let minZoomScale: CGFloat

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
            .gesture(dragGesture, including: transform == .identity ? .none : .all)
            .modify { view in
                if #available(iOS 17.0, *) {
                    view.gesture(magnificationGesture)
                } else {
                    view.gesture(oldMagnificationGesture)
                }
            }
    }

    @available(iOS, introduced: 16.0, deprecated: 17.0)
    private var oldMagnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let zoomFactor = max(value, 1.0)
                let scale = zoomFactor
                transform = lastTransform.scaledBy(x: scale, y: scale)
            }
            .onEnded { _ in
                onEndGesture()
            }
    }

    @available(iOS 17.0, *)
    private var magnificationGesture: some Gesture {
        MagnifyGesture(minimumScaleDelta: 0)
            .onChanged { value in
                let zoomFactor = max(value.magnification, 1.0)
                let newTransform = CGAffineTransform.anchoredScale(
                    scale: zoomFactor,
                    anchor: value.startAnchor.scaledBy(contentSize)
                )

                withAnimation(.interactiveSpring) {
                    transform = lastTransform.concatenating(newTransform)
                }
            }
            .onEnded { _ in
                onEndGesture()
            }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.interactiveSpring) {
                    transform = lastTransform.translatedBy(
                        x: value.translation.width / transform.scaleX,
                        y: value.translation.height / transform.scaleY
                    )
                }
            }
            .onEnded { _ in
                onEndGesture()
            }
    }

    private func onEndGesture() {
        withAnimation(.easeInOut) {
            transform = .identity
            lastTransform = .identity
        }
    }

    private func limitTransform(_ transform: CGAffineTransform) -> CGAffineTransform {
        let scaleX = max(transform.scaleX, minZoomScale)
        let scaleY = max(transform.scaleY, minZoomScale)

        let maxX = contentSize.width * (scaleX - 1)
        let maxY = contentSize.height * (scaleY - 1)

        if transform.tx > 0
            || transform.tx < -maxX
            || transform.ty > 0
            || transform.ty < -maxY
        {
            let tx = min(max(transform.tx, -maxX), 0)
            let ty = min(max(transform.ty, -maxY), 0)
            var transform = transform
            transform.tx = tx
            transform.ty = ty
            return transform
        }

        return transform
    }
}

public extension View {
    @ViewBuilder
    func beZoomable(
        minZoomScale: CGFloat = 1
    ) -> some View {
        modifier(CustomZoomableModifier(minZoomScale: minZoomScale))
    }

    @ViewBuilder
    func beZoomable(
        minZoomScale: CGFloat = 1,
        outOfBoundsColor: Color = .clear
    ) -> some View {
        GeometryReader { proxy in
            ZStack {
                outOfBoundsColor
                self.beZoomable(minZoomScale: minZoomScale)
            }
        }
    }
}

private extension View {
    @ViewBuilder
    func modify(@ViewBuilder _ fn: (Self) -> some View) -> some View {
        fn(self)
    }

    @ViewBuilder
    func animatableTransformEffect(_ transform: CGAffineTransform) -> some View {
        scaleEffect(
            x: transform.scaleX,
            y: transform.scaleY,
            anchor: .zero
        )
        .offset(x: transform.tx, y: transform.ty)
    }
}

private extension UnitPoint {
    func scaledBy(_ size: CGSize) -> CGPoint {
        .init(
            x: x * size.width,
            y: y * size.height
        )
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

#endif
