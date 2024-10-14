//
//  DetailInfoCell.swift
//  DBZApp
//
//  Created by Uri on 4/10/24.
//

import SwiftUI

struct DetailInfoStack: View {
    
    var name: String = Character.mock.name
    var gender: String = Character.mock.genderToDisplay
    var kiPoints: String = Character.mock.kiToDisplay
    var maxKi: String = Character.mock.maxKiToDisplay
    var affiliation: String = Character.mock.affiliation
    var race: String = Character.mock.race
    var description: String = Character.mock.description
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(gender)
                    .font(.title)
                    .frame(width: 20)
            }

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
           
            Text("Description: ")
                .fontWeight(.semibold) +
            Text(description)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DetailInfoStack()
        .padding()
}
