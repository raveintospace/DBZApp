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
    
    static func convertKiPointsToDecimal(_ kiPoints: String) -> Decimal? {
        
        // Remove whitespaces and convert to lowercase
        var normalizedKi = kiPoints
            .trimmingCharacters(in: .whitespaces)
            .lowercased()
        
        // Dictionary for json units
        let suffixes: [String: Decimal] = [
            "googolplex": Decimal(string: "1e+100") ?? Decimal.greatestFiniteMagnitude,
            "septillion": Decimal(string: "1e+24") ?? Decimal.greatestFiniteMagnitude,
            "sextillion": Decimal(string: "1e+21") ?? Decimal.greatestFiniteMagnitude,
            "quintillion": Decimal(string: "1e+18") ?? 1_000_000_000_000_000_000,
            "quadrillion": Decimal(string: "1e+15") ?? 1_000_000_000_000_000,
            "trillion": Decimal(string: "1e+12") ?? 1_000_000_000_000,
            "billion": Decimal(string: "1e+9") ?? 1_000_000_000,
            "million": Decimal(string: "1e+6") ?? 1_000_000,
            "thousand": Decimal(string: "1e+3") ?? 1_000
        ]
        
        // Convert values with suffix
        for (suffix, multiplier) in suffixes.sorted(by: { $0.key.count > $1.key.count }) {
            if normalizedKi.hasSuffix(suffix) {
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
    
    static func formatDecimalToString(_ decimal: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        let suffixes = ["", "", " Million", " Billion", " Trillion", " Quadrillion", " Quintillion", " Sextillion", " Septillion",  " Octillion", " Nonillion", " Decillion", " Undecillion", " Duodecillion", " Tredecillion", " Quattuordecillion", " Quindecillion", " Sexdecillion", " Septendecillion", " Octodecillion", " Novemdecillion", " Vigintillion", " Centillion", " Googolplex"]
        var index = 0
        var value = decimal
        
        let thousand = Decimal(1000)
        let million = Decimal(1_000_000)
        let googolplexThreshold = Decimal(string: "1e+100") ?? Decimal.greatestFiniteMagnitude
        
        // Googolplex Handling
        if value >= googolplexThreshold {
            value /= googolplexThreshold // Reduce to 1e+100
            index = suffixes.count - 1   // Assign "Googolplex"
        } else if value >= million {
            // Use suffixes starting from " M" for values >= 1M
            while value >= thousand && index < suffixes.count - 1 {
                value /= thousand
                index += 1
            }
        }
        
        if let formattedValue = formatter.string(from: NSDecimalNumber(decimal: value)) {
            return "\(formattedValue)\(suffixes[index])"
        }
        
        return "\(value)\(suffixes[index])"
    }
}
