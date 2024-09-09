//
//  Filter.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import SwiftUI

struct Filter: Hashable, Equatable {
    let title: String
    
    static var dbzFilters: [Filter] = [
        Filter(title: "Affiliation"),
        Filter(title: "Gender"),
        Filter(title: "Race")
    ]
}
