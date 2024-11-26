//
//  GameCharacter.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation

struct GameCharacter: Codable, Identifiable {
    let id: Int
    let name: String
    let ki: String
    let image: String
    
    var kiToDisplayInGame: String {
        KiFormatter.formatKiValue(ki)
    }
    
    var kiToCompare: String {
        KiFormatter.kiToCompare(ki)
    }
    
    var isRevealed: Bool = false    
    var isSelected: Bool = false
    
    static var mock: GameCharacter {
        GameCharacter(
            id: 1,
            name: "Goku",
            ki: "60.000.000",
            image: "https://dragonball-api.com/characters/goku_normal.webp",
            isRevealed: false,
            isSelected: false
        )
    }
    
    static var mockTwo: GameCharacter {
        GameCharacter(
            id: 5,
            name: "Freezer",
            ki: "530.000",
            image: "https://dragonball-api.com/characters/Freezer.webp",
            isRevealed: false,
            isSelected: false
        )
    }
    
    static var mockThree: GameCharacter {
        GameCharacter(
            id: 43,
            name: "Vermoudh",
            ki: "9.9 Septillion",
            image: "https://dragonball-api.com/characters/Vermoud.webp",
            isRevealed: false,
            isSelected: false  
        )
    }
}
