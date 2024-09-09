//
//  FilterRepositoryImpl.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import Foundation

class FilterRepositoryImpl: FilterRepository {
    func getFilters() -> [Filter] {
        return [
            Filter(
                title: "Affiliation", subfilters: [
                    Filter(title: "Army of Frieza", subfilters: nil),
                    Filter(title: "Assistant of Beerus", subfilters: nil),
                    Filter(title: "Assistant of Vermoud", subfilters: nil),
                    Filter(title: "Freelancer", subfilters: nil),
                    Filter(title: "Namekian Warrior", subfilters: nil),
                    Filter(title: "Other", subfilters: nil),
                    Filter(title: "Pride Troopers", subfilters: nil),
                    Filter(title: "Red Ribbon Army", subfilters: nil),
                    Filter(title: "Villain", subfilters: nil),
                    Filter(title: "Z Fighter", subfilters: nil)
                ]),
            Filter(title: "Gender", subfilters: [
                Filter(title: "Female", subfilters: nil),
                Filter(title: "Male", subfilters: nil),
                Filter(title: "Other", subfilters: nil),
                Filter(title: "Unknown", subfilters: nil)
            ]),
            Filter(title: "Race", subfilters: [
                Filter(title: "Android", subfilters: nil),
                Filter(title: "Angel", subfilters: nil),
                Filter(title: "Benign Nucleic", subfilters: nil),
                Filter(title: "Evil", subfilters: nil),
                Filter(title: "Frieza Race", subfilters: nil),
                Filter(title: "God", subfilters: nil),
                Filter(title: "Human", subfilters: nil),
                Filter(title: "Jiren Race", subfilters: nil),
                Filter(title: "Majin", subfilters: nil),
                Filter(title: "Namekian", subfilters: nil),
                Filter(title: "Nucleic", subfilters: nil),
                Filter(title: "Saiyan", subfilters: nil),
                Filter(title: "Unknown", subfilters: nil)
            ])
        ]
    }
}
