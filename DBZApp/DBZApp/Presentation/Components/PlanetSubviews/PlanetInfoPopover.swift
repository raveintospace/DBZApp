//
//  PlanetInfoModal.swift
//  DBZApp
//
//  Created by Uri on 24/10/24.
//

import SwiftUI

struct PlanetInfoPopover: View {
    
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
        .foregroundStyle(.dbzYellow)
        .padding(.horizontal)
    }
}

// posar tot en vstack i donar mes padding bottom a modaltitle

#Preview {
    PlanetInfoPopover(title: "Planet info")
        .background(.dbzBlue)
}

extension PlanetInfoPopover {
    
    private var modalTitle: some View {
        Text(title)
            .font(.largeTitle)
            .bold()
            .underline()
    }
    
    private var nameSection: some View {
        Text("Name: ")
            .fontWeight(.bold) +
        Text(name)
    }
    
    private var statusSection: some View {
        Text("Status: ")
            .fontWeight(.bold) +
        Text(status)
    }
    
    private var descriptionSection: some View {
        Text("Description: ")
            .fontWeight(.bold) +
        Text(description)
    }
}
