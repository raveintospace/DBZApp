//
//  GameAlert.swift
//  DBZApp
//
//  Created by Uri on 7/12/24.
//

import Foundation

enum GameAlert: Identifiable {
    case finishMatch
    case playAgain
    
    var id: GameAlert {
        return self
    }
}
