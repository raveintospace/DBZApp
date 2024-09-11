//
//  LocalCharacterDataSource.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

struct LocalCharacterDataSource: CharacterDataSourceProtocol {
    
    func getCharacters() async throws -> [Character] {
        guard let url = Bundle.main.url(forResource: "localDatabase", withExtension: "json") else {
            throw URLError(.badURL)
        }
        
        let characters = try await loadJSON(url: url, type: CharacterArray.self)
        return characters.characters
    }
    
    func loadJSON<JSON: Codable>(url: URL, type: JSON.Type) async throws -> JSON {
        return try await withCheckedThrowingContinuation { continuation in
            Task {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedObject = try JSONDecoder().decode(type, from: data)
                    continuation.resume(returning: decodedObject)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// Data(contentsOf:) isn't async, we have to convert it to take concurrency
// Task so Data((contentsOf:) doesn't block main thread
