//
//  Room.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
//
//struct RoomManager {
//    var id = UUID()
//    var multipeerSession: MPCSession
//    var host: Player
//    var players: [Player]
//}

import MultipeerConnectivity
import SwiftUI

class RoomManager: ObservableObject {
    @Published var availableRooms: [MCPeerID] = [] // Lista de salas (hosts) disponíveis
    
    // Adiciona uma nova sala (host)
    func addRoom(_ peerID: MCPeerID) {
        DispatchQueue.main.async {
            if !self.availableRooms.contains(where: { $0.displayName == peerID.displayName }) {
                self.availableRooms.append(peerID)
                print("➕ Sala adicionada: \(peerID.displayName)")
            }
        }
    }
    
    // Remove uma sala (host)
    func removeRoom(_ peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.availableRooms.removeAll { $0.displayName == peerID.displayName }
            print("➖ Sala removida: \(peerID.displayName)")
        }
    }
}
