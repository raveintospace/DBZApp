//
//  PlanetInfoModal.swift
//  DBZApp
//
//  Created by Uri on 24/10/24.
//

import SwiftUI

struct PlanetInfoModal: View {
    
    var title: String = ""
    var name: String = DetailedCharacter.mock.originPlanet.name
    var status: String = DetailedCharacter.mock.originPlanet.planetStatus
    var description: String = DetailedCharacter.mock.originPlanet.translatedPlanetDescription
    
    var body: some View {
        VStack {
            modalTitle
                .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 12) {
                nameSection
                statusSection
                descriptionSection
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.accent)
        .padding(.horizontal)
    }
}

// posar tot en vstack i donar mes padding bottom a modaltitle

#Preview {
    PlanetInfoModal(title: "Planet info")
}

extension PlanetInfoModal {
    
    private var modalTitle: some View {
        Text(title)
            .font(.largeTitle)
            .bold()
            .underline()
    }
    
    private var nameSection: some View {
        Text("Name: ")
            .fontWeight(.semibold) +
        Text(name)
    }
    
    private var statusSection: some View {
        Text("Status: ")
            .fontWeight(.semibold) +
        Text(status)
    }
    
    private var descriptionSection: some View {
        Text("Description: ")
            .fontWeight(.semibold) +
        Text(description)
    }
}
