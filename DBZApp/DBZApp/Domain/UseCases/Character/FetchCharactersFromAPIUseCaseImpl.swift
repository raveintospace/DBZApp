//
//  FetchCharactersFromAPIUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct FetchCharactersFromAPIUseCaseImpl: FetchCharactersFromAPIUseCaseProtocol {
    var repository: CharacterRepositoryProtocol

    func execute() async throws -> [Character] {
        do {
            return try await repository.fetchCharactersFromAPI()
        } catch {
            debugPrint("Error in FetchCharactersFromAPIUseCase")
            return []
        }
    }
}
