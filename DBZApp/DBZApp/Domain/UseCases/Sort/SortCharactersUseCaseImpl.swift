//
//  SortCharactersUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import Foundation

struct SortCharactersUseCaseImpl: SortCharactersUsecaseProtocol {
    func convertKiPointsToNumber(_ kiPoints: String) -> Decimal? {
        
        // Remove whitespaces, points, commas and convert to lowercase
        let normalizedKi = kiPoints
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: "")
            .lowercased()
        
        // Dictionary for json naming
        let suffixes: [String: Decimal] = [
            "thousand": Decimal(string: "1e+3") ?? 1_000,
            "million": Decimal(string: "1e+6") ?? 1_000_000,
            "billion": Decimal(string: "1e+9") ?? 1_000_000_000,
            "trillion": Decimal(string: "1e+12") ?? 1_000_000_000_000,
            "quadrillion": Decimal(string: "1e+15") ?? 1_000_000_000_000_000,
            "quintillion": Decimal(string: "1e+18") ?? 1_000_000_000_000_000_000,
            "sextillion": Decimal(string: "1e+21") ?? Decimal.greatestFiniteMagnitude,
            "septillion": Decimal(string: "1e+24") ?? Decimal.greatestFiniteMagnitude,
            "googolplex": Decimal(string: "1e+100") ?? Decimal.greatestFiniteMagnitude
        ]
        
        // Set unknown ki as the lowest
        if normalizedKi == "unknown" {
            return Decimal(-1)
        }
        
        // Convert values with suffix
        for (suffix, multiplier) in suffixes {
            if normalizedKi.contains(suffix) {
                let numberPart = normalizedKi.replacingOccurrences(of: suffix, with: "").trimmingCharacters(in: .whitespaces)
                if let number = Decimal(string: numberPart) {
                    return number * multiplier
                }
            }
        }
        
        // Convert String to Decimal for non-suffix values
        return Decimal(string: normalizedKi)
    }
}
