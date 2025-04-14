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
                    Spacer()
                    
                    // Lista de jogadores conectados
                    List(multipeerSession.connectedPeersNames, id: \.self) { player in
                        Text(player)
                            .font(.custom("TorukSC-Regular", size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Image("decorativeRectYellow")
                                    .resizable()
                                    .scaledToFill()
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    Spacer()
                    
                    // Botão "Continue"
//                    Button(action: {
//                        router = .waitingRoom
//                        HUBPhoneManager.instance.changeScreen = true
//                        
//                    }) {
//                        Image("decorativeRectOrange")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 180, height: 60)
//                            .overlay(
//                                Text("Continue")
//                                    .font(.custom("TorukSC-Regular", size: 24))
//                                    .foregroundColor(.white)
//                            )
//                    }
                    
                    //Spacer()
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
