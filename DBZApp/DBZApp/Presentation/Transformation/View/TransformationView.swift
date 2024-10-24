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
    
    var body: some View {
        Text(detailedCharacter.transformations[0].name)
            .onTapGesture {
                router.dismissScreen()
            }
    }
}

#Preview {
    RouterView { _ in
        TransformationView(detailedCharacter: DetailedCharacter.mock)
    }
}
