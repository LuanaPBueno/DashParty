//
//  SendingPlayer.swift
//  DashParty
//
//  Created by Luana Bueno on 07/04/25.
//

import Foundation

struct SendingPlayer: Codable {
    var id: UUID
    var currentSituation: Bool
    var currentChallenge: Challenge
}

