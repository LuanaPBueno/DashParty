//
//  ChooseHierarqyView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import Foundation
import SwiftUI
import SwiftUI
import MultipeerConnectivity

struct ChooseHierarchyView: View {
    @State private var navigateToRoomListView = false
    @State private var navigateToRoomView = false
    @ObservedObject private var multipeerSession = MPCSessionManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Host") {
                multipeerSession.host = true
                multipeerSession.start()
                navigateToRoomView = true
            }
            
            Button("Player") {
                multipeerSession.host = false
                navigateToRoomListView = true
            }
        }
        .navigationDestination(isPresented: $navigateToRoomListView) {
            RoomListView(multipeerSession: multipeerSession)
        }
        .navigationDestination(isPresented: $navigateToRoomView) {
            RoomView(multipeerSession: multipeerSession)
        }
    }
}
