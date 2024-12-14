//
//  SoundModel.swift
//  DBZApp
//
//  Created by Uri on 14/12/24.
//

import Foundation

struct SoundModel: Hashable {
    let name: String
    
    func getURL() -> URL? {
        guard let path = Bundle.main.path(forResource: name, ofType: "wav") else {
            debugPrint("Failed to find path for resource: \(name).wav")
            return nil
        }
        return URL(fileURLWithPath: path)
    }
}
