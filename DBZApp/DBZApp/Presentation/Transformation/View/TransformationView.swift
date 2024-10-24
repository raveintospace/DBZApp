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
        VStack {
            ForEach(detailedCharacter.transformations, id: \.self) { transformation in
                Text(transformation.name)
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        TransformationView(detailedCharacter: DetailedCharacter.mock)
    }
}
