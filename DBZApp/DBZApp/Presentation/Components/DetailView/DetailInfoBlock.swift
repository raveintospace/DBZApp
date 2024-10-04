//
//  DetailInfoCell.swift
//  DBZApp
//
//  Created by Uri on 4/10/24.
//

import SwiftUI

struct DetailInfoBlock: View {
    
    var name: String = Character.mock.name
    var gender: String = Character.mock.genderToDisplay
    var kiPoints: String = Character.mock.kiToDisplay
    var maxKi: String = Character.mock.maxKiToDisplay
    var affiliation: String = Character.mock.affiliation
    var race: String = Character.mock.race
    var description: String = Character.mock.description
    
    @State private var showFullDescription: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            nameGenderSection
            yellowDivider
            propertiesSection
            yellowDivider
            descriptionTitle
            descriptionSection
            yellowDivider
        }
        .foregroundStyle(.accent)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DetailInfoBlock()
        .padding()
}

extension DetailInfoBlock {
    
    private var nameGenderSection: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(name.uppercased())
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(gender)
                .font(.title)
                .frame(width: 20)
        }
    }
    
    private var propertiesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ki points: ")
                .fontWeight(.semibold) +
            Text(kiPoints)
            
            Text("Max ki points: ")
                .fontWeight(.semibold) +
            Text(maxKi)
            
            Text("Affiliation: ")
                .fontWeight(.semibold) +
            Text(affiliation)
            
            Text("Race: ")
                .fontWeight(.semibold) +
            Text(race)
        }
    }
    
    private var descriptionTitle: some View {
        Text("Description")
            .font(.title2)
            .bold()
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text(description)
                .lineLimit(showFullDescription ? nil : 5)
            
            Button(action: {
                showFullDescription.toggle()
            }, label: {
                Text(showFullDescription ? "Show less" : "Read more...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.dbzBlue)
                    .padding(.vertical, 4)
            })
        }
    }
    
    private var yellowDivider: some View {
        Divider()
            .overlay(.dbzYellow)
            .padding(.horizontal, -25)
    }
}
