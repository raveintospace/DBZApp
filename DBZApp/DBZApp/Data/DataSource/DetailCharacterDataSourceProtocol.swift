//
//  DetailCharacterDataSourceProtocol.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

protocol DetailCharacterDataSourceProtocol {
    func getDetailedCharacter(id: Int) async throws -> DetailedCharacter
}
