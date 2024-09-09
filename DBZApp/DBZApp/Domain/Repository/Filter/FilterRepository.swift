//
//  FilterRepository.swift
//  DBZApp
//
//  Created by Uri on 9/9/24.
//

import Foundation

protocol FilterRepository {
    func getFilters() -> [Filter]
}
