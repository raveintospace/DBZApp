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
            //horizontalSlider
            transformationsSlider
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
    
    private var horizontalSlider: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(detailedCharacter.transformations, id: \.self) { transformation in
                    TransformationCard(
                        name: transformation.name,
                        imageName: transformation.image,
                        kiPoints: transformation.ki
                    )
                    .background(.red)
                }
            }
        }
        .padding(.top, 50)
    }
    
    private var transformationsSlider: some View {
        TabView(selection: $sliderCurrentIndex) {
            ForEach(detailedCharacter.transformations, id: \.self) { transformation in
                TransformationCard(
                    name: transformation.name,
                    imageName: transformation.image,
                    kiPoints: transformation.ki
                )
                .background(.red)
                .tag(transformation)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
        .padding(.top, 50)
    }
    
    private func setupTabViewAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .dbzOrange
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.dbzYellow
    }
}
