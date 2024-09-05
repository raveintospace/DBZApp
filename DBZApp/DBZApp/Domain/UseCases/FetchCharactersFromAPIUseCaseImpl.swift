//
//  FetchCharactersFromAPIUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct FetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseProtocol {
    var repository: CharacterRepository

    func execute() async -> [Character] {
        do {
            return try await repository.fetchCharactersFromAPI()
        } catch {
            debugPrint("Error in FetchCharactersFromAPIUseCase")
            return []
        }
    }
}
