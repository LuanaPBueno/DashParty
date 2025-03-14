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
    var currentChallenge: Challenge {
        challenges[Int(progress/100)]
    }
}
