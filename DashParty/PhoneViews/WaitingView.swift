//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//


import Foundation
import SwiftUI

struct WaitingView: View {
    @Binding var router:Router
    var multipeerSession: MPCSession
    
//    @State private var navigateHost: Bool = false
    @State private var navigateToPlayerDisplayView: Bool = false
    
    var body: some View {
    
            ZStack { 
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    VStack{
                        ZStack{
                            
                            Text("Waiting for players to join...")
                                .font(.custom("TorukSC-Regular", size: 34, relativeTo: .title2))
                                .multilineTextAlignment(.center)
                            
                            
                            HStack {
                                Button {
                                    router = .play
                                } label: {
                                    Image("backButton")
                                    
                                }
                                .padding(.leading, 16)
                                Spacer()
                            }
                        }
                        .padding(.leading, 35)
                        .padding(.top, 35)
                        Spacer()
                        HStack{
                            ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                                MMPhone(playerName: player, sizePadding: 0)
                            }
                        }
                        .padding(.top, 30)
                        Spacer()
                        
                    }
                    Spacer()
                    
                    // Lista de jogadores conectados
                    HStack{
                        ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                            MMPhone(playerName: player, sizePadding: 0)
                        }
                    }
                    Spacer()
                }
                .padding()
                .onAppear {
                    if !multipeerSession.host {
                        navigateToPlayerDisplayView = true
                    }
                }
            }
            .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) { newValue in
                print("Peers conectados: \(newValue)")
            }
//            .navigationDestination(isPresented: $navigateHost) {
//                CharacterView(multipeerSession: multipeerSession)
//            }
        
        .task {
            print("Host? \(multipeerSession.host)")
            print("Meu PeerID: \(multipeerSession.mcSession.myPeerID)")
        }
    }
}

#Preview {
    WaitingView(router: .constant(.waitingRoom), multipeerSession: MPCSessionManager.shared)
}
