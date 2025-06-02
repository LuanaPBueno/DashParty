//
//  AudioManager.swift
//  DashParty
//
//  Created by Luana Bueno on 13/05/25.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    private var audioPlayers: [String: AVAudioPlayer] = [:]

    func playSound(named name: String, ofType type: String = "mp3", volume: Float = 1.0, loop: Bool = true) {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            print("⚠️ Áudio '\(name)' não encontrado.")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = 0//0.01
            player.numberOfLoops = loop ? -1 : 0
            player.prepareToPlay()
            player.play()

            audioPlayers[name] = player 
        } catch {
            print("⚠️ Erro ao tocar o som '\(name)': \(error.localizedDescription)")
        }
    }

    func stopSound(named name: String) {
        audioPlayers[name]?.stop()
        audioPlayers.removeValue(forKey: name)
    }

    func stopAllSounds() {
        for player in audioPlayers.values {
            player.stop()
        }
        audioPlayers.removeAll()
    }
}
