//
//  FilterCell.swift
//  DBZApp
//
//  Created by Uri on 6/9/24.
//

import SwiftUI

enum FilterState {
    case notPressed
    case pressedOnce
    case pressedTwice
}

struct FilterCell: View {
    
    var title: String = "Filters"
    @Binding var filterState: FilterState
    
    var body: some View {
        Text(title)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    Capsule(style: .circular)
                        .fill(filterState == .pressedOnce ? Color.dbzYellow : Color.dbzOrange)
                        .opacity(filterState == .notPressed ? 0 : 1)
                    
                    Capsule(style: .circular)
                        .stroke(lineWidth: 1)
                }
            )
            .foregroundStyle(.light)
            .onTapGesture {
                switch filterState {
                case .notPressed:
                    filterState = .pressedOnce
                case .pressedOnce:
                    filterState = .pressedTwice
                case .pressedTwice:
                    filterState = .notPressed
                }
            }
    }
}

#Preview {
    VStack {
        FilterCell(title: "Affiliation", filterState: .constant(.notPressed))
        FilterCell(title: "Gender", filterState: .constant(.pressedOnce))
        FilterCell(title: "Race", filterState: .constant(.pressedTwice))
    }
}

/*
 Affiliation / Gender / Race
 
 1 Quan premem un cop se selecciona el boto i apareix l'X (igual que netflix)
 2 Amb el boto seleccionat, si premem un segon cop se selecciona l'opcio i canvia el titol del boto
 3 Si premem X, es deselecciona el boto i el filtre
 4. Color 1 yellow / Color 2 orange
 
 */
