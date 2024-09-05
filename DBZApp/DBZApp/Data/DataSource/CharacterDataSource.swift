//
//  CharacterDataSource.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

// Contract that defines how we want to get the message from a source (local, network...)
protocol CharacterDataSource {
    func getCharacters() async throws -> [Character]
}

