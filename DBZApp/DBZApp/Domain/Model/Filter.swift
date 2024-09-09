//
//  Filter.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import SwiftUI

struct Filter: Hashable, Equatable {
    let title: String
    let subfilters: [String]
    
    static var dbzFilters: [Filter] = [
        Filter(title: "Affiliation", subfilters: ["Army of Frieza", "Assistant of Beerus", "Assistant of Vermoud", "Freelancer", "Namekian Warrior", "Other", "Pride Troopers", "Red Ribbon Army", "Villain", "Z Fighter"]),
        Filter(title: "Gender", subfilters: ["Male", "Female", "Other", "Unknown"]),
        Filter(title: "Race", subfilters: ["Android", "Angel", "Benign Nucleic", "Evil", "Frieza Race", "God", "Human", "Jiren Race", "Majin", "Namekian", "Nucleic", "Saiyan", "Unknown"])
    ]
}
