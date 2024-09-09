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
