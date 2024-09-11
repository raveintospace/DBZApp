//
//  CharacterRepository.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

// Interface between the domain and the data layer
protocol CharacterRepositoryProtocol {
    func getLocalCharacters() async throws -> [Character]
    func fetchCharactersFromAPI() async throws -> [Character]
}
