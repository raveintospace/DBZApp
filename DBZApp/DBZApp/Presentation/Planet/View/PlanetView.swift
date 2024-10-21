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
    
    @State private var showPlanetModal: Bool = false
    
    var detailedCharacter: DetailedCharacter
    
    var body: some View {
        ZStack {
            PlanetImageCell()
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RouterView { _ in
        PlanetView(detailedCharacter: DetailedCharacter.mock)
    }
}

extension PlanetView {
    
    private var header: some View {
        PlanetHeaderBar(
            headerTitle: detailedCharacter.originPlanet.translatedPlanetName,
            showPlanetModal: showPlanetModal,
            onBackButtonPressed: {
                router.dismissScreen()
            },
            onFavButtonPressed: {
                withAnimation {
                    showPlanetModal.toggle()
                }
            }
        )
        .padding()
        .padding(.top, -10)
    }
}
