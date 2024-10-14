//
//  FetchDetailCharacterUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

struct FetchDetailCharacterUseCaseImpl: FetchDetailCharacterUseCaseProtocol {
    private let repository: DetailCharacterRepositoryProtocol
    
    init(repository: DetailCharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> DetailedCharacter {
        do {
            return try await repository.getDetailCharacter(id: id)
        } catch {
            debugPrint("Error in FetchDetailCharacterUseCase: \(error.localizedDescription)")
            throw error
        }
    }
}
