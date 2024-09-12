//
//  GetFiltersUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 11/9/24.
//

import Foundation

struct GetFiltersUseCaseImpl: GetFiltersUseCaseProtocol {
    private let repository: FilterRepositoryProtocol
    
    init(repository: FilterRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeAffiliationFilters() async throws -> [Filter] {
        return try await repository.getAffiliationFilters()
    }
    
    func executeGenderFilters() async throws -> [Filter] {
        return try await repository.getGenderFilters()
    }
    
    func executeRaceFilters() async throws -> [Filter] {
        return try await repository.getRaceFilters()
    }
    
    func executeFilterTitles() async throws -> [String] {
        return try await repository.getFilterTitles()
    }
}
