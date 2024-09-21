//
//  DatabaseCardView.swift
//  DBZApp
//
//  Created by Uri on 21/9/24.
//

import SwiftUI

struct DatabaseCardView: View {
    
    var imageName: String = Character.mock.image
    var name: String = Character.mock.name
    var ki: String = Character.mock.kiToDisplay
    var affiliation: String = Character.mock.affiliation
    var race: String = Character.mock.race
    var gender: String = Character.mock.gender
    
    var isFavorite: Bool = false
    var onCardPressed: (() -> Void)? = nil
    var onFavButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DatabaseCardView()
}
