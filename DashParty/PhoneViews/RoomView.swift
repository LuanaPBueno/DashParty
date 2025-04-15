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
                        Spacer()
//                        Button {
//                            router = .play
//                        } label: {
//                            Image("backButton")
//                        }
                        HStack{
                            
                            
                            Button {
                                print("clicou no back")
                            } label: {
                                Image("backButton")
                            }
                            Spacer()
                            
                            Text("Waiting for players to join...")
                                .font(.custom("TorukSC-Regular", size: 34))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                        }
                        Text("Connected players:")
                            .font(.custom("TorukSC-Regular", size: 24))
                            .foregroundColor(.white)

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
    let matchManager = ChallengeManager()
    let session = MPCSession(service: "banana", identity: "maçã", maxPeers: 5, matchManager: matchManager)
    
    // Simular host e jogadores conectados para visualização
    session.host = true
    session.connectedPeersNames = ["Alice", "Bob", "Charlie"]
    
    return RoomView(router: .constant(.matchmaking), multipeerSession: session)
}
