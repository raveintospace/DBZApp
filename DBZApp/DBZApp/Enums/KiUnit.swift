//
//  KiUnit.swift
//  DBZApp
//
//  Created by Uri on 24/11/24.
//

import Foundation

enum KiUnit: String {
    case thousand = "K"
    case million = "M"
    case billion = "B"
    case trillion = "T"
    case quadrillion = "Quad"
    case quintillion = "Quint"
    case sextillion = "Sext"
    case septillion = "Sept"
    case googolplex = "Gp"
    
    var multiplier: NSDecimalNumber {
        switch self {
        case .thousand: return NSDecimalNumber(string: "1000")
        case .million: return NSDecimalNumber(string: "1000000")
        case .billion: return NSDecimalNumber(string: "1000000000")
        case .trillion: return NSDecimalNumber(string: "1000000000000")
        case .quadrillion: return NSDecimalNumber(string: "1000000000000000")
        case .quintillion: return NSDecimalNumber(string: "1000000000000000000")
        case .sextillion: return NSDecimalNumber(string: "1000000000000000000000")
        case .septillion: return NSDecimalNumber(string: "1000000000000000000000000")
        case .googolplex: return NSDecimalNumber(string: "1e+100")
        }
    }
    
    static func fromSuffix(_ suffix: String) -> KiUnit? {
        switch suffix.lowercased() {
        case "thousand": return .thousand
        case "million": return .million
        case "billion": return .billion
        case "trillion": return .trillion
        case "quadrillion": return .quadrillion
        case "quintillion": return .quintillion
        case "sextillion": return .sextillion
        case "septillion": return .septillion
        case "googolplex": return .googolplex
        default: return nil
        }
    }
}
