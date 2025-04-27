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
            
            if multipeerSession.host {
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
                    
                    HStack{
                        ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                            MMPhone(playerName: player, sizePadding: 0)
                        }
                    }
                    .padding(.top, 30)
                    
                    
                }
                .foregroundColor(.white)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            router = .storyBoard
                        } label: {
                            OrangeButtonPhone(text: "Continue", sizeFont: 20)
                                .frame(width: 110, height: 45)
                        }
                        .padding(.trailing, 40)
                        .padding(.bottom, 12)
                        
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
