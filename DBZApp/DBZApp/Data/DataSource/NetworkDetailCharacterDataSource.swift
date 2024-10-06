//
//  NetworkDetailCharacterDataSource.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

actor NetworkDetailCharacterDataSource: DetailCharacterDataSourceProtocol {
    
    private let dataService = DataService()
    
    func getDetailedCharacter(id: Int) async throws -> DetailedCharacter {
        guard let apiURL = URL(string: "https://dragonball-api.com/api/characters/\(id)") else {
            throw URLError(.badURL)
        }
        
        return try await dataService.fetch(type: DetailedCharacter.self, url: apiURL)
    }
}
