//
//  Room.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation

struct RoomManager {
    var id = UUID()
    var multipeerSession: MPCSession
    var host: Player
    var players: [Player]
}
