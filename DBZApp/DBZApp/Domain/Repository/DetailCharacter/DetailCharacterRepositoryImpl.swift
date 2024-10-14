//
//  DetailCharacterRepositoryImpl.swift
//  DBZApp
//
//  Created by Uri on 6/10/24.
//

import Foundation

struct DetailCharacterRepositoryImpl: DetailCharacterRepositoryProtocol {
    private let dataSource: NetworkDetailCharacterDataSource
    
    init(dataSource: NetworkDetailCharacterDataSource) {
        self.dataSource = dataSource
    }
    
    func getDetailCharacter(id: Int) async throws -> DetailedCharacter {
        return try await dataSource.getDetailedCharacter(id: id)
    }
}
