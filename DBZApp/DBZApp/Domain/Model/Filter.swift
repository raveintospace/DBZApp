//
//  Filter.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import SwiftUI

struct Filter: Hashable, Equatable {
    let title: String
    
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
}

/*

 enum Affiliation: String, CaseIterable {
     case armyOfFrieza = "Army of Frieza"
     case assistantOfBeerus = "Assistant of Beerus"
     case assistantOfVermoud = "Assistant of Vermoud"
     case freelancer = "Freelancer"
     case namekianWarrior = "Namekian Warrior"
     case other = "Other"
     case prideTroopers = "Pride Troopers"
     case redRibbonArmy = "Red Ribbon Army"
     case villain = "Villain"
     case zFighter = "Z Fighter"
 }

 enum Gender: String, CaseIterable {
     case female = "Female"
     case male = "Male"
     case other = "Other"
     case unknown = "Unknown"
 }

 enum Race: String, CaseIterable {
     case android = "Android"
     case angel = "Angel"
     case benignNucleic = "Benign Nucleic"
     case evil = "Evil"
     case friezaRace = "Frieza Race"
     case god = "God"
     case human = "Human"
     case jirenRace = "Jiren Race"
     case majin = "Majin"
     case namekian = "Namekian"
     case nucleic = "Nucleic"
     case saiyan = "Saiyan"
     case unknown = "Unknown"
 }



 */
