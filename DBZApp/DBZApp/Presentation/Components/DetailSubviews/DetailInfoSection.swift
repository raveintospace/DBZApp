//
//  DetailInfoCell.swift
//  DBZApp
//
//  Created by Uri on 4/10/24.
//

import SwiftUI

struct DetailInfoSection: View {
    
    var name: String = Character.mock.name
    var gender: String = Character.mock.genderToDisplay
    var kiPoints: String = Character.mock.kiToDisplay
    var maxKi: String = Character.mock.maxKiToDisplay
    var affiliation: String = Character.mock.affiliation
    var race: String = Character.mock.race
    var description: String = Character.mock.description
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            nameGenderSection
            DBZDivider()
            propertiesSection
            DBZDivider()
            descriptionSection
            DBZDivider()
        }
        .foregroundStyle(.accent)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DetailInfoSection()
        .padding()
}

extension DetailInfoSection {
    
    private var nameGenderSection: some View {
        HStack(spacing: 0) {
            Text(name.uppercased())
                .lineLimit(3)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(gender)
                .font(.title)
                .frame(width: 30)
        }
    }
    
    private var propertiesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ki points: ")
                .fontWeight(.semibold) +
            Text(kiPoints)
            
            Text("Max Ki points: ")
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
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.title2)
                .bold()
            
            ExpandableText(text: description)
                .lineLimit(5)
                .expandButton(TextSet(text: "Read more", font: .caption, fontWeight: .bold, color: .dbzBlue))
                .collapseButton(TextSet(text: "Show less", font: .caption, fontWeight: .bold, color: .dbzBlue))
        }
    }
}
