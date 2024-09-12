//
//  FilterRepositoryProtocol.swift
//  DBZApp
//
//  Created by Uri on 11/9/24.
//

import Foundation

protocol FilterRepositoryProtocol {
    func getAffiliationFilters() async throws -> [Filter]
    func getGenderFilters() async throws -> [Filter]
    func getRaceFilters() async throws -> [Filter]
}
