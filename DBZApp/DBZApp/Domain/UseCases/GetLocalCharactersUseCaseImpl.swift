//
//  GetLocalCharactersUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct GetLocalCharactersUseCase: GetLocalCharactersUseCaseProtocol {
    var repository: CharacterRepository

    func execute() async -> Result<[Character], UseCaseError> {
        do {
            let characters = try await repository.getLocalCharacters()
            return .success(characters)
        } catch {
            return .failure(.undefinedError)
        }
    }
}
