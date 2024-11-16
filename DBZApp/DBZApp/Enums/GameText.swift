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
            return "Game\nwon"
        case .gameLost:
            return "Game\nlost"
        case .draw:
            return "Draw"
        case .setWon:
            return "Set\nwon"
        case .setLost:
            return "Set\nlost"
        case .matchWon:
            return "Match\nwon"
        case .matchLost:
            return "Match\nlost"
        case .welcome:
            return "Welcome"
        case .empty:
            return ""
        }
    }
}
