//
//  GameCharacter.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation

struct GameCharacter: Codable {
    let name: String
    let ki: String
    let image: String
    
    var kiToDisplay: String {
        KiFormatter.formatKiValue(ki)
    }
    
    var kiToCompare: String {
        KiFormatter.kiToCompare(ki)
    }
    
    static var mock: GameCharacter {
        GameCharacter(
            name: "Goku",
            ki: "60.000.000",
            image: "https://dragonball-api.com/characters/goku_normal.webp"
        )
    }
    
    static var mockTwo: GameCharacter {
        GameCharacter(
            name: "Freezer",
            ki: "530.000",
            image: "https://dragonball-api.com/characters/Freezer.webp"
        )
    }
}
