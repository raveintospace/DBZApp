//
//  GameCharacterMapper.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation

struct GameCharacterMapper {
    static func mapCharacterToGameCharacter(_ character: Character) -> GameCharacter {
        return GameCharacter(
            name: character.name,
            ki: character.ki,
            image: character.image
        )
    }
}
