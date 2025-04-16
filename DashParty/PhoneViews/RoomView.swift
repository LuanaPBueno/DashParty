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
            VStack{
                Spacer()
                HStack{
                    Button {
                        router = .play
                    } label: {
                        Image("backButton")
                    }

                    Spacer()
                }
            }
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
          
                if multipeerSession.host {
                    
                    VStack{
                        Spacer()
                        
                        HStack{
                            Button {
                                router = .play
                            } label: {
                                Image("backButton")
                            }
                            
                            Spacer()
                            
                            Text("Waiting for players to join...")
                                .font(.custom("TorukSC-Regular", size: 30, relativeTo: .title))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                        }
                        
                        Text("Connected Players:")
                            .font(.custom("TorukSC-Regular", size: 20))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                         
                        HStack{
                            ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                                MMPhone(playerName: player)
                            }
                        }
                        
                        
                        Spacer()
                        
                        HStack{
                            Button {
                                router = .storyBoard
                            } label: {
                                OrangeButtonPhone(text: "Continue", sizeFont: 20)
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.1)
                            
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

//#Preview {
//    RoomView(router: .constant(.matchmaking), multipeerSession: MPCSession(service: "banana", identity: "maça", maxPeers: 5, matchManager: ChallengeManager()))
//}

#Preview {
    let matchManager = ChallengeManager()
    let session = MPCSession(service: "banana", identity: "maçã", maxPeers: 5, matchManager: matchManager)
    
    // Simular host e jogadores conectados para visualização
    session.host = true
    session.connectedPeersNames = ["Alice", "Bob", "Charlie"]
    
    
    return RoomView(router: .constant(.matchmaking), multipeerSession: session)
}
