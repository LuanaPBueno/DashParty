//
//  GuessingView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import SwiftUI

struct RoomView: View {
    //MARK: Deixar observable
    @Binding var router:Router
    @ObservedObject var multipeerSession: MPCSession
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false
    
    var body: some View {
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                if multipeerSession.host {
                    VStack{
                        Button {
                            router = .play
                        } label: {
                            Image("backButton")
                        }
                        HStack{
                            
                            Text("Waiting for players to join...")
                                .font(.custom("TorukSC-Regular", size: 34))
                        }
                        Text("Connected players:")
                            .font(.custom("TorukSC-Regular", size: 24))
                        List(multipeerSession.connectedPeersNames, id: \.self) { player in
                            Text(player)
                        }
                        Button {
                            router = .storyBoard
                        } label: {
                            OrangeButtonPhone(text: "Continue", sizeFont: 34)
                        }
                        
                        
                        
                    }
                }
                
            }
        }
        .scrollContentBackground(.hidden)
        
        .task{
            if !multipeerSession.host {
                navigateToPlayerDisplayView = true
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

#Preview {
    RoomView(router: .constant(.matchmaking), multipeerSession: MPCSession(service: "banana", identity: "maça", maxPeers: 5, matchManager: ChallengeManager()))
}
