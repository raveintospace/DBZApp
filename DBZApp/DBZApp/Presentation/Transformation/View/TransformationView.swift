//
//  TransformationView.swift
//  DBZApp
//
//  Created by Uri on 24/10/24.
//

import SwiftUI
import SwiftfulRouting

struct TransformationView: View {
    
    @Environment(\.router) var router
    
    var detailedCharacter: DetailedCharacter
    
    @State private var sliderCurrentIndex: Int = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                transformationsSlider
                customPageControl
            }
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    RouterView { _ in
        TransformationView(detailedCharacter: DetailedCharacter.mock)
    }
}

extension TransformationView {
    
    private var header: some View {
        TransformationHeaderButton(onBackButtonPressed: {
            router.dismissScreen()
        })
        .padding()
        .padding(.top, -10)
    }
    
    private var transformationsSlider: some View {
        TabView(selection: $sliderCurrentIndex) {
            ForEach(Array(detailedCharacter.transformations.enumerated()), id: \.offset) { index, transformation in
                TransformationCard(
                    name: transformation.name,
                    imageName: transformation.image,
                    kiPoints: transformation.ki
                )
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.top, 50)
    }
    
    private var customPageControl: some View {
        HStack {
            ForEach(0..<detailedCharacter.transformations.count, id: \.self) { index in
                Circle()
                    .fill(index == sliderCurrentIndex ? .dbzOrange : .dbzYellow)
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut, value: sliderCurrentIndex)
            }
        }
    }
}
