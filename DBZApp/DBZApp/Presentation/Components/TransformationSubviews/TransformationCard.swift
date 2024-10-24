//
//  TransformationCard.swift
//  DBZApp
//
//  Created by Uri on 24/10/24.
//

import SwiftUI

struct TransformationCard: View {
    
    var name: String = DetailedCharacter.mock.transformations[0].name
    var imageName: String = DetailedCharacter.mock.transformations[0].image
    var kiPoints: String = DetailedCharacter.mock.transformations[0].ki
    
    var body: some View {
        VStack(spacing: 0) {
            nameSection
            ImageLoaderView(url: imageName)
            kiSection
        }
    }
}

#Preview {
    TransformationCard()
}

extension TransformationCard {
    
    private var nameSection: some View {
        Text(name)
            .font(.title2)
            .bold()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .foregroundStyle(.accent)
    }
    
    private var kiSection: some View {
        Text("Ki points: ")
            .font(.title3)
            .fontWeight(.semibold) +
        Text(kiPoints)
            .fontWeight(.semibold)
    }
}
