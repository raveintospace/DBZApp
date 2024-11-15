//
//  GameText.swift
//  DBZApp
//
//  Created by Uri on 15/11/24.
//

import Foundation

enum GameText {
    case gameWon
    case gameLost
    case draw
    case setWon
    case setLost
    case matchWon
    case matchLost
    case welcome
    case empty
    
    var message: String {
        switch self {
        case .gameWon:
            return "Game won"
        case .gameLost:
            return "Game lost"
        case .draw:
            return "Draw"
        case .setWon:
            return "Set won"
        case .setLost:
            return "Set lost"
        case .matchWon:
            return "Match won"
        case .matchLost:
            return "Match lost"
        case .welcome:
            return "Welcome"
        case .empty:
            return ""
        }
    }
}
