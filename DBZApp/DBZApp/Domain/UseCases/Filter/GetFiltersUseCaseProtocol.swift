//
//  GetFiltersUseCaseProtocol.swift
//  DBZApp
//
//  Created by Uri on 11/9/24.
//

import Foundation

protocol GetFiltersUseCaseProtocol {
    func executeAffiliationFilters() async throws -> [Filter]
    func executeGenderFilters() async throws -> [Filter]
    func executeRaceFilters() async throws -> [Filter]
}
