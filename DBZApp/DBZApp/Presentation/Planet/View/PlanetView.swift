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
        ZStack {
            Text("close view")
                .frame(maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    router.dismissScreen()
                }
            PlanetImageCell()
        }
    }
}

#Preview {
    RouterView { _ in
        PlanetView()
    }
}
