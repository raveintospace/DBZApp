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
    
    var detailedCharacter: DetailedCharacter
    
    var body: some View {
        ZStack {
            planetWallpaper
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
            
            PlanetImageCell(imageName: detailedCharacter.originPlanet.image)
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
    
    private var planetWallpaper: some View {
        Image("planetsWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.20)
    }
    
    private var header: some View {
        PlanetHeaderBar(
            headerTitle: detailedCharacter.originPlanet.translatedPlanetName,
            onBackButtonPressed: {
                router.dismissScreen()
            },
            onInfoButtonPressed: {
                router.showModal(
                    transition: AnyTransition.scale.animation(.easeInOut),
                    backgroundColor: Color.black.opacity(0.001),
                    ignoreSafeArea: false) {
                        planetPopover
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    }
            }
        )
        .padding()
        .padding(.top, -10)
    }
    
    private var planetPopover: some View {
        PlanetInfoPopover(
            title: "Planet info",
            name: detailedCharacter.originPlanet.translatedPlanetName,
            status: detailedCharacter.originPlanet.planetStatus,
            description: detailedCharacter.originPlanet.translatedPlanetDescription
        )
        .padding(.vertical)
        .background(.dbzBlue)
        .cornerRadius(20)
    }
}
