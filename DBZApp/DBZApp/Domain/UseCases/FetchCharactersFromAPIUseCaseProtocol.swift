//
//  FetchCharactersFromAPIUseCaseProtocol.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

protocol FetchCharactersFromAPIUseCaseProtocol {
    func execute() async throws -> [Character]
}
