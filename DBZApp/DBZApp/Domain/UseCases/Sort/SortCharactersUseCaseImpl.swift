//
//  SortCharactersUseCaseImpl.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import Foundation

struct SortCharactersUseCaseImpl: SortCharactersUsecaseProtocol {
    func executeConvertKiPointsToNumber(_ kiPoints: String) -> Decimal? {
        
        // Remove whitespaces and convert to lowercase
        var normalizedKi = kiPoints
            .trimmingCharacters(in: .whitespaces)
            .lowercased()
        
        // Dictionary for json units
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
                
                // Get the numeric part, keeping decimal points
                let numberPart = normalizedKi.replacingOccurrences(of: suffix, with: "").trimmingCharacters(in: .whitespaces)
                
                // Convert numeric part to Decimal, including decimals
                if let number = Decimal(string: numberPart.replacingOccurrences(of: ",", with: "")) {
                    return number * multiplier
                }
            }
        }
        
        normalizedKi = normalizedKi.replacingOccurrences(of: ".", with: "")
        
        // Convert String to Decimal for non-suffix values
        return Decimal(string: normalizedKi)
    }
}
