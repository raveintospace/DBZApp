//
//  FilterRepositoryImpl.swift
//  DBZApp
//
//  Created by Uri on 11/9/24.
//

import Foundation

struct FilterRepositoryImpl: FilterRepositoryProtocol {
    func getAffiliationFilters() async throws -> [Filter] {
        return [
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
    }
    
    func getGenderFilters() async throws -> [Filter] {
        return [
            Filter(title: "Female"),
            Filter(title: "Male"),
            Filter(title: "Other"),
            Filter(title: "Unknown")
        ]
    }
    
    func getRaceFilters() async throws -> [Filter] {
        return [
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
}
