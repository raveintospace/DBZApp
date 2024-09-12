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
            Filter(title: "army of frieza"),
            Filter(title: "assistant of beerus"),
            Filter(title: "assistant of vermoud"),
            Filter(title: "freelancer"),
            Filter(title: "namekian warrior"),
            Filter(title: "other"),
            Filter(title: "pride troopers"),
            Filter(title: "red ribbon army"),
            Filter(title: "villain"),
            Filter(title: "z fighter")
        ]
    }
    
    func getGenderFilters() async throws -> [Filter] {
        return [
            Filter(title: "female"),
            Filter(title: "male"),
            Filter(title: "other"),
            Filter(title: "unknown")
        ]
    }
    
    func getRaceFilters() async throws -> [Filter] {
        return [
            Filter(title: "android"),
            Filter(title: "angel"),
            Filter(title: "benign nucleic"),
            Filter(title: "evil"),
            Filter(title: "frieza race"),
            Filter(title: "god"),
            Filter(title: "human"),
            Filter(title: "jiren race"),
            Filter(title: "majin"),
            Filter(title: "namekian"),
            Filter(title: "nucleic"),
            Filter(title: "saiyan"),
            Filter(title: "unknown")
        ]
    }
    
    func getFilterTitles() async throws -> [String] {
        return [
            "Affiliation",
            "Gender",
            "Race"
        ]
    }
}
