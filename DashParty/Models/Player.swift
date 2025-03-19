//
//  Player.swift
//  DashParty
//
//  Created by Luana Bueno on 14/03/25.
//

import Foundation

struct Player: Identifiable, Hashable, Equatable {
    var id = UUID()
    var user: User
    var challenges: [Challenge]
    var progress: Double = 0
    var currentChallenge: Challenge? {
        let index = Int(progress / 100)
        if index >= 0 && index < challenges.count {
            return challenges[index]
        } else {
            return Challenge .stopped
        }
    }
    
    init (user: User, challenges: [Challenge]) {
        self.user = user
        self.challenges = [.running] + challenges
    }
}
