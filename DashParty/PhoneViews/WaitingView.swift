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
    
    @State private var navigateToPlayerDisplayView: Bool = false
    
    var body: some View {
    
            ZStack { 
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    HStack{
                        
                        Button {
                            multipeerSession.mcSession.disconnect()
                            router = .play
                           
                        } label: {
                            Image("backButton")
                                .padding(.leading, 28)
                                .padding(.top, 28)
                        }
                       
                        Spacer()
                    }
                    Spacer()
                    
                  
                    HStack{
                        Text(multipeerSession.hostPeerID!.displayName)
                        
                            MMPhone(playerName: multipeerSession.hostName, sizePadding: 0)
                            MMPhone(playerName: HUBPhoneManager.instance.playername, sizePadding: 0)
                        
                        ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                            if player == multipeerSession.hostPeerID!.displayName {
                               Text("")
                            }else{
                                MMPhone(playerName: player, sizePadding: 0)
                            }
                        }
                    }
                    
                    Button {
                        
//                        router = .play
                        router = .chooseCharacter
                       
                    } label: {
                        OrangeButtonPhone(text: "Continue", sizeFont: 28)
                            .frame(width: 150, height: 45)
                            
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
