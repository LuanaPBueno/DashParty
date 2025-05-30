//
//  PlayerState.swift
//  DashParty
//
//  Created by Luana Bueno on 07/04/25.
//

import Foundation

struct PlayerState: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var currentSituation: Bool
    var currentChallenge: Challenge
    var youWon: Bool
    var interval: TimeInterval
    var progress: Double
    var userClan : Clan?
}

