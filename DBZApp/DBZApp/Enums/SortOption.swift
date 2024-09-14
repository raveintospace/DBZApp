//
//  SortOption.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import SwiftUI

enum SortOption: String, CaseIterable {
    case name
    case nameReversed
    case kiPoints
    case kiPointsReversed
    case id
    case idReversed
    
    func displayName() -> some View {
        switch self {
        case .name:
            return HStack(spacing: 4) {
                Text("Name")
                Image(systemName: "chevron.down")
            }
        case .nameReversed:
            return HStack(spacing: 4) {
                Text("Name")
                Image(systemName: "chevron.up")
            }
        case .kiPoints:
            return HStack(spacing: 4) {
                Text("Ki Points")
                Image(systemName: "chevron.down")
            }
        case .kiPointsReversed:
            return HStack(spacing: 4) {
                Text("Ki Points")
                Image(systemName: "chevron.up")
            }
        case .id:
            return HStack(spacing: 4) {
                Text("ID")
                Image(systemName: "chevron.down")
            }
        case .idReversed:
            return HStack(spacing: 4) {
                Text("ID")
                Image(systemName: "chevron.up")
            }
        }
    }
}

// Sort of SortOption is reversed so options in SortMenu appear alphabetically
