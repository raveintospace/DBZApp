//
//  GetLocalCharactersUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct GetLocalCharactersUseCaseImpl: GetLocalCharactersUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Character] {
        do {
            return try await repository.getLocalCharacters()
        } catch {
            debugPrint("Error in GetLocalCharactersUseCase")
            return []
        }
    }
}
