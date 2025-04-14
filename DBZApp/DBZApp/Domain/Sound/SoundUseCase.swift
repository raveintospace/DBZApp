//
//  SoundUseCase.swift
//  DBZApp
//
//  Created by Uri on 14/4/25.
//

import Foundation

final class SoundUseCase {
    private let soundUserDefaultsKey: String = "soundSetting"
    
    private(set) var isSoundEnabled: Bool = true
    
    init() {
        isSoundEnabled = getSoundSetting()
    }
    
    func setSoundActivated(value: Bool) {
        isSoundEnabled = value
        encodeAndSaveSoundSetting()
    }
    
    private func encodeAndSaveSoundSetting() {
        do {
            let encoded = try JSONEncoder().encode(isSoundEnabled)
            UserDefaults.standard.set(encoded, forKey: soundUserDefaultsKey)
        } catch {
            debugPrint("Error encoding sound setting: \(error)")
        }
    }
    
    private func getSoundSetting() -> Bool {
        if let soundSettingData = UserDefaults.standard.object(forKey: soundUserDefaultsKey) as? Data {
            do {
                let soundSetting = try JSONDecoder().decode(Bool.self, from: soundSettingData)
                return soundSetting
            } catch {
                debugPrint("Error decoding sound setting: \(error)")
            }
        }
        return true // Default value
    }
}
