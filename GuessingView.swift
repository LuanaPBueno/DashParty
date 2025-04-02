//
//  GuessingView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import SwiftUI

struct RoomView: View {
    //MARK: Deixar observable 
    @State var t = false
    var multipeerSession: MPCSession
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false

    var body: some View {
        VStack {
           
            Text(t.description)
            Button {
                t.toggle()
            } label: {
                Text("atualizar")
            }
            
            if multipeerSession.host {
                VStack{
                Text("Im host")
                Text("Jogadores conectados:")
                    .font(.headline)
                    List(multipeerSession.mcSession.connectedPeers.map { $0.displayName }, id: \.self) { player in
                        Text(player)
                        
                    }
                    Button {
                        self.navigateHost = true
                    } label: {
                        Text("Start Tutorial")
                    }

                }
            }
           
        }
        .task{
            if !multipeerSession.host {
                navigateToPlayerDisplayView = true
            }
        }
        .navigationDestination(isPresented: $navigateHost, destination: {
            ConnectInHubView(multipeerSession: multipeerSession)
        })
//        .navigationDestination(isPresented: $navigateToPlayerDisplayView, destination: {
//            ConnectInHubView()
//        })
        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) {
            print(multipeerSession.mcSession.connectedPeers.map { $0.displayName })
        }
        .task{
            print(multipeerSession.host)
            print(multipeerSession.mcSession.myPeerID)
        }
    }
}
