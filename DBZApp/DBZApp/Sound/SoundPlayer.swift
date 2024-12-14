//
//  SoundPlayer.swift
//  DBZApp
//
//  Created by Uri on 14/12/24.
//

import Foundation
import AVKit

class SoundPlayer {
    var player: AVAudioPlayer?
    
    func play(withURL: URL) {
        player = try! AVAudioPlayer(contentsOf: withURL)
        player?.prepareToPlay()
        player?.play()
    }
}
