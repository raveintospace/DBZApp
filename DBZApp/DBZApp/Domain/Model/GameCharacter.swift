//
//  GameCharacter.swift
//  DBZApp
//
//  Created by Uri on 5/11/24.
//

import Foundation

struct GameCharacter: Codable {
    let name: String
    let ki: String
    let image: String
    
    private func formatKiValue(_ value: String) -> String {
        let normalizedValue = value.replacingOccurrences(of: ",", with: ".")
        let components = normalizedValue.split(separator: " ")
        
        if components.count == 2 {
            let number = components[0]
            let unit = components[1].capitalized
            return "\(number) \(unit)"
        }
        
        return normalizedValue.capitalized
    }
    
    var kiToDisplay: String {
        return formatKiValue(ki)
    }
    
    var kiToCompare: String {
        return ki.replacingOccurrences(of: ",", with: "")
    }
}
