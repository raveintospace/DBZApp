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
        ZStack {
            header
                .frame(maxHeight: .infinity, alignment: .top)
            
            VStack {
                ForEach(detailedCharacter.transformations, id: \.self) { transformation in
                    Text(transformation.name)
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

extension TransformationView {
    
    private var header: some View {
        TransformationHeaderButton(onBackButtonPressed: {
            router.dismissScreen()
        })
        .padding()
        .padding(.top, -10)
    }
}
