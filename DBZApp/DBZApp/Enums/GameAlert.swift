//
//  GameAlert.swift
//  DBZApp
//
//  Created by Uri on 7/12/24.
//

import Foundation

enum GameAlertType: Identifiable {
    case resetMatch
    case playAgain
    
    var id: GameAlertType {
        return self
    }
}
