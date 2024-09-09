//
//  FilterCell.swift
//  DBZApp
//
//  Created by Uri on 6/9/24.
//

import SwiftUI

struct FilterCell: View {
    
    var title: String = "Filters"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    Capsule(style: .circular)
                        .fill(.dbzYellow)
                        .opacity(isSelected ? 1 : 0)
                    
                    Capsule(style: .circular)
                        .stroke(lineWidth: 1)
                }
            )
            .foregroundStyle(.dbzBlue)
    }
}

#Preview {
    VStack {
        FilterCell(title: "Affiliation", isSelected: false)
        FilterCell(title: "Gender", isSelected: true)
        FilterCell(title: "Race", isSelected: false)
    }
}

/*
 Affiliation / Gender / Race
 
 1 Quan premem un cop se selecciona el boto i apareix l'X (igual que netflix)
 2 Amb el boto seleccionat, si premem un segon cop se selecciona l'opcio i canvia el titol del boto
 3 Si premem X, es deselecciona el boto i el filtre
 4. Color 1 yellow / Color 2 orange
 
 */
