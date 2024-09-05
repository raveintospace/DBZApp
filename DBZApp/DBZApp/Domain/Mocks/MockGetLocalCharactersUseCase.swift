//
//  MockGetLocalCharactersUseCase.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct MockGetLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol {
    func execute() async throws -> [Character] {
        return [Character.mock, Character.mockTwo]
    }
}
