//
//  NetworkCharacterDataSource.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

actor NetworkCharacterDataSource: CharacterDataSourceProtocol {
    
    private let apiURL = URL(string: "https://dragonball-api.com/api/characters?limit=1000000")
    private let dataService = DataService()
    
    func getCharacters() async throws -> [Character] {
        let characters = try await dataService.fetch(type: CharacterArray.self, url: apiURL)
        return characters.characters
    }
}
