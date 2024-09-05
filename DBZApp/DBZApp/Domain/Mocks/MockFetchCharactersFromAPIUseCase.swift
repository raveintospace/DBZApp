//
//  MockFetchCharactersFromAPIUseCase.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct MockFetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol {
    func execute() async throws -> [Character] {
        return [Character.mock, Character.mockTwo]
    }
}
