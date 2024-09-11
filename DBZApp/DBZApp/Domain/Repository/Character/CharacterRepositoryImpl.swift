//
//  CharacterRepositoryImpl.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct CharacterRepositoryImpl: CharacterRepositoryProtocol {
    private let localDataSource: LocalCharacterDataSource
    private let networkDataSource: NetworkCharacterDataSource
    
    init(localDataSource: LocalCharacterDataSource, networkDataSource: NetworkCharacterDataSource) {
        self.localDataSource = localDataSource
        self.networkDataSource = networkDataSource
    }
    
    // Load characters from the local data source
    func getLocalCharacters() async throws -> [Character] {
        return try await localDataSource.getCharacters()
    }
    
    // Fetch characters from the network data source
    func fetchCharactersFromAPI() async throws -> [Character] {
        return try await networkDataSource.getCharacters()
    }
}
