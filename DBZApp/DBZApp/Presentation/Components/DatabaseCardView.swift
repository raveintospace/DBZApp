//
//  DatabaseCardView.swift
//  DBZApp
//
//  Created by Uri on 21/9/24.
//

import SwiftUI
import SwiftfulUI

struct DatabaseCardView: View {
    
    var imageName: String = Character.mock.image
    var name: String = Character.mock.name
    var ki: String = Character.mock.kiToDisplay
    var affiliation: String = Character.mock.affiliation
    var race: String = Character.mock.race
    var gender: String = Character.mock.genderToDisplay
    
    var isFavorite: Bool = false
    var onCardPressed: (() -> Void)? = nil
    var onFavButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            characterImage
            characterInfo
        }
        .foregroundStyle(.accent)
        .background(.dbzBlue.opacity(0.1))
        .clipShape(.rect(cornerRadius: 10))
        .aspectRatio(0.8, contentMode: .fit)
        .asButton(.tap) {
            onCardPressed?()
        }
    }
}

#Preview {
    NonLazyVGrid(columns: 2, alignment: .center, items: [Character.mock, Character.mockTwo]) { character in
        if let character {
            DatabaseCardView(
                imageName: character.image,
                name: character.name,
                ki: character.kiToDisplay,
                affiliation: character.affiliation,
                race: character.race,
                gender: character.genderToDisplay,
                isFavorite: false,
                onCardPressed: {
                    // go to detail view
                },
                onFavButtonPressed: {
                    // viewmodel favorite
                }
            )
        }
    }
}

extension DatabaseCardView {
    
    private var characterImage: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(url: imageName)
                .padding(.top, 8)
            ImageOrangeCircleButton(
                imageName: isFavorite ? "star.fill" : "star",
                frameSize: 26,
                fontSize: 13
            )
                .padding(.trailing, 8)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .asButton(.press) {
                    onFavButtonPressed?()
                }
        }
    }
    
    private var characterInfo: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(gender)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            Text("\(ki) ki points")
                .font(.caption)
                .fontWeight(.semibold)
            Text("Affiliation: \(affiliation)")
                .font(.caption)
            Text("Race: \(race)")
                .font(.caption)
        }
        .padding(.top, 0)
        .padding(.horizontal)
        .padding(.bottom)
    }
}