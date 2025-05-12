//
//  MatchmakingHubView.swift
//  DashParty
//
//  Created by Fernanda Auler on 15/04/25.
//

//
//  MatchmakingHubView.swift
//  DashParty
//
//  Created by Fernanda Auler on 15/04/25.
//

import SwiftUI

struct MatchmakingHubView: View {
    //MARK: Deixar observable
    @Binding var router:Router
    @ObservedObject var multipeerSession: MPCSession
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false
    
    var body: some View {
        ZStack{
//            VStack{
//                Spacer()
//                HStack{
//                    Button {
//                        router = .play
//                    } label: {
//                        Image("backButton")
//                    }
//
//                    Spacer()
//                }
//            }
            Image("patternBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Text(HUBPhoneManager.instance.roomName)
                    .font(.custom("TorukSC-Regular", size: 120, relativeTo: .largeTitle))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, 40)
                //if multipeerSession.host {
                    VStack{
                        Spacer()
                        HStack{
                           // Text(HUBPhoneManager.instance.roomName)
                            MMPhone(playerName: HUBPhoneManager.instance.playername , sizePadding: 0)
                            ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                                MMPhone(playerName: player, sizePadding: 0)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 1.4)

                      
                        
                        Spacer()
                        
                    }
                //}
          }
        .scrollContentBackground(.hidden)
        
        .task{
            if !multipeerSession.host {
                navigateToPlayerDisplayView = true
            }
        }
        //        .navigationDestination(isPresented: $navigateHost, destination: {
        //            WaitingView(multipeerSession: multipeerSession)
        //        })
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

#Preview {
    let matchManager = ChallengeManager()
    let session = MPCSession(service: "banana", identity: "maçã", maxPeers: 5, matchManager: matchManager)
    
    // Simular host e jogadores conectados para visualização
    session.host = true
    
    
    return MatchmakingHubView(router: .constant(.matchmaking), multipeerSession: session)
}
