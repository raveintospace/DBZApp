//
//  SoundPlayer.swift
//  DBZApp
//
//  Created by Uri on 14/12/24.
//

import Foundation
import AVFoundation

class SoundPlayer {
    var player: AVAudioPlayer?
    
    func play(withURL url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            debugPrint("Failed to play sound: \(error.localizedDescription)")
        }
    }
}
