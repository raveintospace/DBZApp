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
}
