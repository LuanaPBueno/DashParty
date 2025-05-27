//
//  MatchmakingHubView.swift
//  DashParty
//
//  Created by Fernanda Auler on 15/04/25.
//


import SwiftUI

struct MatchmakingHubView: View {
    @Binding var router:Router
    @ObservedObject var multipeerSession: MPCSession
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false
    @State var audioManager: AudioManager = AudioManager()
    
    var size: CGSize
    
    var body: some View {
        
        VStack {
            
            Text(GameInformation.instance.roomName)
                .font(.custom("TorukSC-Regular", size: (size.width / 1920) * 60))             .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            HStack{
                
                ConnectedPlayerCard(playerName: GameInformation.instance.playername , sizePadding: 0)
                ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                    ConnectedPlayerCard(playerName: player, sizePadding: 0)
                    
                }
                
            }
            .frame(height: size.height * 0.5)
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Image("backgroundNewHUB")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
//        .scrollContentBackground(.hidden)
//
        .onAppear{
            audioManager.playSound(named:"forest")
        }
        
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
    let hubManager = GameInformation.instance
        hubManager.roomName = "Floresta Mística"
    
        hubManager.playername = "Raposa"
    let matchManager = MatchManager()
    let session = MPCSession(
        service: "banana",
        identity: "maçã",
        maxPeers: 5,
        matchManager: matchManager
    )
    
    session.host = true
    session.connectedPeersNames = ["Tigre", "Coruja", "Lobo"]

    return MatchmakingHubView(
        router: .constant(.matchmaking),
        multipeerSession: session,
        size: CGSize(width: 2388, height: 1668)
    )
}
