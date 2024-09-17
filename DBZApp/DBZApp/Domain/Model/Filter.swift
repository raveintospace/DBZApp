//
//  Filter.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import SwiftUI

struct Filter: Hashable, Equatable, Identifiable {
    let id: UUID
    let title: String
    
    init(id: UUID = UUID(), title: String) {
            self.id = id
            self.title = title
        }
    
    // only for mock purposes
    static var affiliation: [Filter] = [
        Filter(title: "Army of Frieza"),
        Filter(title: "Assistant of Beerus"),
        Filter(title: "Assistant of Vermoud"),
        Filter(title: "Freelancer"),
        Filter(title: "Namekian Warrior"),
        Filter(title: "Other"),
        Filter(title: "Pride Troopers"),
        Filter(title: "Red Ribbon Army"),
        Filter(title: "Villain"),
        Filter(title: "Z Fighter")
    ]
    
    static var gender: [Filter] = [
        Filter(title: "Female"),
        Filter(title: "Male"),
        Filter(title: "Other"),
        Filter(title: "Unknown")
    ]
    
    static var race: [Filter] = [
        Filter(title: "Android"),
        Filter(title: "Angel"),
        Filter(title: "Benign Nucleic"),
        Filter(title: "Evil"),
        Filter(title: "Frieza Race"),
        Filter(title: "God"),
        Filter(title: "Human"),
        Filter(title: "Jiren Race"),
        Filter(title: "Majin"),
        Filter(title: "Namekian"),
        Filter(title: "Nucleic"),
        Filter(title: "Saiyan"),
        Filter(title: "Unknown")
    ]
}
