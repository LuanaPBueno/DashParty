//
//  MotionDat.swift
//  DashParty
//
//  Created by Luana Bueno on 02/04/25.
//

import Foundation
struct MotionData: Codable {
    let x: Double
    let y: Double
    let z: Double
    let magnitude: Double
    let challenge: String
    let progress: Double
    let playerId: UUID
}

// Método para codificar e enviar dados de movimento
func sendMotionData(_ data: MotionData) {
    do {
        let encoder = JSONEncoder()
        let motionData = try encoder.encode(data)
      //  sendDataToAllPeers(data: motionData)
    } catch {
        print("Error encoding motion data: \(error)")
    }
}
