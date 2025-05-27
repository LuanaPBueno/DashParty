//
//  MotionData.swift
//  DashParty
//
//  Created by Luana Bueno on 02/04/25.
//

import Foundation

struct MotionData: Codable {
    let playerId: UUID
    let attitude: AttitudeData
    let position: CGPoint  // Vamos remover o opcional
    let currentChallenge: String?
    let currentSituation: Bool
}

struct AttitudeData: Codable {
    let roll: Double
    let pitch: Double
    let yaw: Double
}
