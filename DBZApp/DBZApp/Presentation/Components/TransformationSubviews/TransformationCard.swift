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
                .padding(.horizontal)
                .frame(alignment: .top)
            ImageLoaderView(url: imageName)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            kiSection
                .frame(alignment: .bottom)
        }
        .foregroundStyle(.accent)
    }
}

#Preview {
    TransformationCard()
}

extension TransformationCard {
    
    private var nameSection: some View {
        Text(name.uppercased())
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .font(.title2)
            .bold()
    }
    
    private var kiSection: some View {
        Text("Ki points: ")
            .font(.title3)
            .fontWeight(.semibold) +
        Text(kiPoints)
    }
}
