//
//  FetchCharactersFromAPIUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct FetchCharactersFromAPIUseCaseImpl: FetchCharactersFromAPIUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Character] {
        do {
            return try await repository.fetchCharactersFromAPI()
        } catch {
            debugPrint("Error in FetchCharactersFromAPIUseCase")
            return []
        }
    }
}
