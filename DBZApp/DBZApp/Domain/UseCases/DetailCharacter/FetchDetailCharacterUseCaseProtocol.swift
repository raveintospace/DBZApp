//
//  FetchDetailCharacterUseCaseProtocol.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

protocol FetchDetailCharacterUseCaseProtocol {
    func execute(id: Int) async throws -> DetailedCharacter
}
