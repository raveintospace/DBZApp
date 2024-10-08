//
//  GetLocalCharactersUseCaseProtocol.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

protocol GetLocalCharactersUseCaseProtocol {
    func execute() async throws -> [Character]
}
