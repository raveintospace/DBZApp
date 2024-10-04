//
//  Character.swift
//  DBZApp
//  https://dragonball-api.com/api/characters?limit=1000000
//  Created by Uri on 5/9/24.
//

import Foundation

struct CharacterArray: Codable {
    let characters: [Character]
    let meta: Meta
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case characters = "items"
        case meta
        case links
    }
}

// MARK: - Item
struct Character: Codable, Identifiable {
    let id: Int
    let name, ki, maxKi, race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    
    // MARK: - Mocks
    static var mock: Character {
        Character(
            id: 444,
            name: "Goku",
            ki: "60.000.000",
            maxKi: "90 Septillion",
            race: "Saiyan",
            gender: "Male",
            description: "The protagonist of the series, known for his great power and friendly personality. Originally sent to Earth as a flying infant with the mission to conquer it. However, falling down a cliff gave him a brutal blow that almost killed him, but altered his memory and nullified all the violent instincts of his species, which made him grow up with a pure and kind heart, but retaining all the powers of his race. However, in the new Dragon Ball continuity it is established that he was sent by his parents to Earth with the goal of surviving at all costs the destruction of his planet by Freeza. Later, Kakarot, now known as Son Goku, would become the prince consort of Mount Fry-pan and leader of the Z Warriors, as well as the greatest defender of Earth and Universe 7, managing to keep them safe from destruction on countless occasions, despite not considering himself a hero or savior.",
            image: "https://dragonball-api.com/characters/goku_normal.webp",
            affiliation: "Z Fighter"
        )
    }
    
    static var mockTwo: Character {
        Character(
            id: 333,
            name: "Freezer",
            ki: "530.000",
            maxKi: "52.71 Septillion",
            race: "Frieza Race",
            gender: "Male",
            description: "Freezer is the space tyrant and the main antagonist of the Freezer saga.",
            image: "https://dragonball-api.com/characters/Freezer.webp",
            affiliation: "Army of Frieza"
        )
    }
    
    // MARK: - Computed properties
    var genderToDisplay: String {
        switch gender.lowercased() {
        case "male":
            return "♂︎"
        case "female":
            return "♀️"
        case "other":
            return "⚤"
        case "unknown":
            return "⁉️"
        default:
            return "📛"
        }
    }
    
    var kiToDisplay: String {
        let normalizedKi = ki.replacingOccurrences(of: ",", with: ".")
        
        let components = ki.split(separator: " ")
        
        if components.count == 2 {
            let value = components[0]
            let unit = components[1].capitalized
            return "\(value) \(unit)"
        }
        
        return normalizedKi.capitalized   // capitalize Unknown
    }
    
    var kiToCompare: String {
        return ki.replacingOccurrences(of: ",", with: "")
    }
    
    var maxKiToDisplay: String {
        let normalizedMaxKi = maxKi.replacingOccurrences(of: ",", with: ".")
        
        let components = maxKi.split(separator: " ")
        
        if components.count == 2 {
            let value = components[0]
            let unit = components[1].capitalized
            return "\(value) \(unit)"
        }
        
        return normalizedMaxKi.capitalized   // capitalize Unknown
    }
    
    
}

// MARK: - Links
struct Links: Codable {
    let first: String
    let previous, next: String?
    let last: String
}

// MARK: - Meta
struct Meta: Codable {
    let totalItems, itemCount, itemsPerPage, totalPages: Int
    let currentPage: Int
}
