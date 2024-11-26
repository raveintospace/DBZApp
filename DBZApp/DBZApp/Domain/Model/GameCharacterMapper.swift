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
            id: character.id,
            name: character.name,
            ki: character.ki,
            image: character.image,
            isRevealed: false,
            isSelected: false
        )
    }
}
