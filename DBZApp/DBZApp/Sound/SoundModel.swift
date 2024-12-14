//
//  SoundModel.swift
//  DBZApp
//
//  Created by Uri on 14/12/24.
//

import Foundation

struct SoundModel: Hashable {
    let name: String
    
    func getURL() -> URL {
        return URL(string: Bundle.main.path(forResource: name, ofType: "wav")!)!
    }
}
