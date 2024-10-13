//
//  PlanetView.swift
//  DBZApp
//
//  Created by Uri on 13/10/24.
//

import SwiftUI
import SwiftfulRouting

struct PlanetView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        Text("This is the planet view")
            .onTapGesture {
                router.dismissScreen()
            }
    }
}

#Preview {
    RouterView { _ in
        PlanetView()
    }
}
