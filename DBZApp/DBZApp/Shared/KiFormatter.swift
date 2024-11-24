//
//  KiFormatter.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation

struct KiFormatter {
    
    static func formatKiValue(_ value: String) -> String {
        let normalizedValue = value.replacingOccurrences(of: ",", with: ".")
        let components = normalizedValue.split(separator: " ")
        
        if components.count == 2 {
            let number = components[0]
            let unit = components[1].capitalized
            return "\(number) \(unit)"
        }
        
        return normalizedValue.capitalized
    }
    
    static func kiToCompare(_ value: String) -> String {
        value.replacingOccurrences(of: ",", with: "")
    }
    
    static func formatKiPointsForGameCard(_ value: Decimal) -> String {
        let suffixes: [(suffix: String, multiplier: Decimal)] = [
            ("G", Decimal(string: "1e+100") ?? Decimal.greatestFiniteMagnitude), // Googolplex
            ("S", Decimal(string: "1e+24") ?? Decimal.greatestFiniteMagnitude),  // Septillion
            ("Q", Decimal(string: "1e+18") ?? Decimal.greatestFiniteMagnitude),  // Quintillion
            ("Qu", Decimal(string: "1e+15") ?? Decimal.greatestFiniteMagnitude), // Quadrillion
            ("T", Decimal(string: "1e+12") ?? Decimal.greatestFiniteMagnitude),  // Trillion
            ("B", Decimal(string: "1e+9") ?? Decimal.greatestFiniteMagnitude),   // Billion
            ("M", Decimal(string: "1e+6") ?? Decimal.greatestFiniteMagnitude),   // Million
            ("K", Decimal(string: "1e+3") ?? 1_000)                             // Thousand
        ]
        
        for (suffix, multiplier) in suffixes {
            if value >= multiplier {
                let reducedValue = value / multiplier
                
                // Limit to 1 or 2 decimals for reduced values
                let formattedValue = String(format: "%.2f", Double(truncating: reducedValue as NSNumber))
                    .replacingOccurrences(of: ".00", with: "") // Remove unnecessary decimals
                return "\(formattedValue)\(suffix)"
            }
        }
        
        // When ki points are < 1000
        return "\(value)"
    }
}
