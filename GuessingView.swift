//
//  GuessingView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import SwiftUI

struct RoomView: View {
    @State var t = false
    var multipeerSession: MPCSession

    var body: some View {
        VStack {
           
            Text(t.description)
            Button {
                t.toggle()
            } label: {
                Text("atualizar")
            }
            if multipeerSession.host {
                Text("Im host")
                Text("Jogadores conectados:")
                    .font(.headline)
                List(multipeerSession.mcSession.connectedPeers.map { $0.displayName }, id: \.self) { player in
                    Text(player)
                }
            }
        }
        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) {
            print(multipeerSession.mcSession.connectedPeers.map { $0.displayName })
        }
        .task{
            print(multipeerSession.host)
            print(multipeerSession.mcSession.myPeerID)
        }
    }
}
