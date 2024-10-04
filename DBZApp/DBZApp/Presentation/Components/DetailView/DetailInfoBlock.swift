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
            //.padding(.bottom, 8)

            Divider()
                .overlay(.dbzYellow)
                .padding(.horizontal, -25)
            
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
            
            Divider()
                .overlay(.dbzYellow)
                .padding(.horizontal, -25)
           
            Text("Description")
                .font(.title2)
                .bold()
                .padding(.top, 8)
             //   .background(.blue)
            descriptionSection
            
            Divider()
                .overlay(.dbzYellow)
                .padding(.horizontal, -25)
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
    
    private var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text(description)
                .lineLimit(showFullDescription ? nil : 5)
            
            Button(action: {
          //      withAnimation(.smooth) {
                    showFullDescription.toggle()
             //   }
            }, label: {
                Text(showFullDescription ? "Show less" : "Read more...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            })
            .tint(.dbzBlue)
        }
    }
}
