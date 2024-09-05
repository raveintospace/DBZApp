//
//  FetchCharactersFromAPIUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct FetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol {
    var repository: CharacterRepository

    func execute() async -> Result<[Character], UseCaseError> {
        do {
            let characters = try await repository.fetchCharactersFromAPI()
            return .success(characters)
        } catch {
            return .failure(.networkError)
        }
    }
}
