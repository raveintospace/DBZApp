//
//  DetailCharacterRepositoryProtocol.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

protocol DetailCharacterRepositoryProtocol {
    func getDetailCharacter(id: Int) async throws -> DetailedCharacter
}
