//
//  PlanetInfoModal.swift
//  DBZApp
//
//  Created by Uri on 24/10/24.
//

import SwiftUI

struct PlanetInfoModal: View {
    
    var name: String = DetailedCharacter.mock.originPlanet.name
    var status: String = DetailedCharacter.mock.originPlanet.planetStatus
    var description: String = DetailedCharacter.mock.originPlanet.translatedPlanetDescription
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(name)
            Text(status)
            Text(description)
        }
        .foregroundStyle(.accent)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PlanetInfoModal()
}


