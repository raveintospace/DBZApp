//
//  FilterOption.swift
//  DBZApp
//
//  Created by Uri on 11/9/24.
//

import SwiftUI

enum FilterOption: String, CaseIterable {
    case affiliation, gender, race
    
    func displayName() -> some View {
        switch self {
        case .affiliation:
            return Text("Affiliation")
        case .gender:
            return Text("Gender")
        case .race:
            return Text("Race")
        }
    }
}
